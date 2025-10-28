import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';
import 'package:pull_up_ritual/common/themes/app_spacing.dart';
import 'package:pull_up_ritual/common/themes/app_typography.dart';
import 'package:pull_up_ritual/common/widgets/gradient_button.dart';
import 'package:pull_up_ritual/common/widgets/home_button.dart';
import 'package:pull_up_ritual/common/widgets/screen_scaffold.dart';
import 'package:pull_up_ritual/features/workout/widgets/set_cards.dart';
import 'package:pull_up_ritual/features/workout/providers/workout_provider.dart';
import 'package:pull_up_ritual/common/utils/utils.dart';

class RestScreen extends StatefulWidget {
  const RestScreen({super.key});

  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  bool _didPop = false;
  late final WorkoutProvider _workoutProvider;

  @override
  void initState() {
    super.initState();
    _workoutProvider = context.read<WorkoutProvider>();
    _workoutProvider.addListener(_onWorkoutChanged);

    // If we somehow arrive when not resting, pop once after first frame
    if (!_workoutProvider.isResting()) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _safePop());
    }
  }

  void _onWorkoutChanged() {
    if (!_workoutProvider.isResting()) {
      _safePop();
    }
  }

  void _safePop() {
    if (_didPop) return;
    _didPop = true;
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _workoutProvider.removeListener(_onWorkoutChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var workoutProvider = context.watch<WorkoutProvider>();

    return ScreenScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: AppSpacing.sm),
          Text('😴', style: AppTypography.displayMedium.copyWith(fontSize: 64)),
          _RestTimerSpinner(size: 200.0),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: GradientButton(
              onPressed: () {
                workoutProvider.resume();
                // no need to route to a different screen here as the state
                // change causes this function to rerun and call the same
                // code that would run if the timer reached 0.
              },
              text: "Skip Rest",
              icon: Icons.skip_next,
              gradient: AppGradients.secondary,
            ),
          ),
          SetCards(
            values: getSetCardValues(workoutProvider.workout),
            numExpectedCards: workoutProvider.workout.maxGroups,
          ),
          HomeButton(text: "Exit", icon: Icons.exit_to_app),
        ],
      ),
    );
  }
}

class _RestTimerSpinner extends StatefulWidget {
  final double size;
  const _RestTimerSpinner({required this.size});
  @override
  State<_RestTimerSpinner> createState() => _RestTimerSpinnerState();
}

class _RestTimerSpinnerState extends State<_RestTimerSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2_000),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider = context.read<WorkoutProvider>();

    final remaining = workoutProvider.restTimeRemaining;

    const double ringThickness = 6;
    const double arcPortion = 0.25;

    return Column(
      children: [
        SizedBox(
          height: widget.size,
          width: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              RotationTransition(
                turns: _controller,
                child: SizedBox(
                  height: widget.size,
                  width: widget.size,
                  child: CircularProgressIndicator(
                    value: arcPortion,
                    strokeWidth: ringThickness,
                    backgroundColor: AppColors.glassBorderInactive,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.glassBorderActive,
                    ),
                  ),
                ),
              ),
              // center content
              Text(
                formatMinutesSeconds(remaining),
                style: AppTypography.displayLarge.copyWith(fontSize: 50),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
