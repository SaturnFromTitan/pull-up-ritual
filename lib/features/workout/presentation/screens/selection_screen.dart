import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_up_ritual/features/workout/data/models.dart'
    show WorkoutType;
import 'package:pull_up_ritual/features/workout/presentation/providers/workout_provider.dart'
    show WorkoutProvider;
import 'package:pull_up_ritual/features/workout/presentation/screens/max_sets_screen.dart'
    show MaxSetsScreen;
import 'package:pull_up_ritual/features/workout/presentation/screens/ladders_screen.dart'
    show LaddersScreen;
import 'package:pull_up_ritual/features/workout/presentation/screens/submax_volume_screen.dart'
    show SubmaxVolumeScreen;
import 'package:pull_up_ritual/features/workout/presentation/widgets/reps_form.dart'
    show RepsForm;
import 'package:pull_up_ritual/core/widgets/gradient_background.dart'
    show GradientBackground;
import 'package:pull_up_ritual/core/widgets/workout_card.dart' show WorkoutCard;
import 'package:pull_up_ritual/core/widgets/gradient_button.dart'
    show GradientButton;
import 'package:pull_up_ritual/core/themes/app_spacing.dart' show AppSpacing;
import 'package:pull_up_ritual/core/themes/app_typography.dart'
    show AppTypography;
import 'package:pull_up_ritual/core/constants/app_constants.dart'
    show AppConstants;

class WorkoutSelectionScreen extends StatefulWidget {
  const WorkoutSelectionScreen({super.key});

  @override
  State<WorkoutSelectionScreen> createState() => _WorkoutSelectionScreenState();
}

class _WorkoutSelectionScreenState extends State<WorkoutSelectionScreen> {
  WorkoutType _selected = WorkoutType.maxSets;

  Future<int?> askForTargetReps() async {
    var res = await showDialog<int>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Enter Your Target Reps', style: TextStyle(fontSize: 18)),
                SizedBox(height: 20),
                RepsForm(
                  onValidSubmit: (int reps) => Navigator.pop(context, reps),
                  onCancel: () => Navigator.pop(context),
                  minValue: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
    return res;
  }

  void _handleSubmit() async {
    StatefulWidget workoutScreen;
    switch (_selected) {
      case WorkoutType.maxSets:
        workoutScreen = MaxSetsScreen();
      case WorkoutType.submaxVolume:
        var targetReps = await askForTargetReps();
        if (!mounted || targetReps == null) return null;
        workoutScreen = SubmaxVolumeScreen(targetReps: targetReps);
      case WorkoutType.ladders:
        workoutScreen = LaddersScreen();
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => WorkoutProvider(workoutType: _selected),
          child: workoutScreen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                _buildHeader(),

                const SizedBox(height: AppSpacing.cardGap),

                // Workout cards section
                Expanded(
                  child: Column(
                    children: [
                      WorkoutCard(
                        title: 'Max Sets',
                        description: '3x max reps with 5min rest',
                        icon: const Icon(
                          Icons.fitness_center,
                          color: Colors.white,
                          size: 27,
                        ),
                        isSelected: _selected == WorkoutType.maxSets,
                        onTap: () =>
                            setState(() => _selected = WorkoutType.maxSets),
                      ),

                      const SizedBox(height: AppSpacing.cardGap),

                      WorkoutCard(
                        title: 'Submax Volume',
                        description: '10 sets at 50% max with 1min rest',
                        icon: const Icon(
                          Icons.timeline,
                          color: Colors.white,
                          size: 27,
                        ),
                        isSelected: _selected == WorkoutType.submaxVolume,
                        onTap: () => setState(
                          () => _selected = WorkoutType.submaxVolume,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.cardGap),

                      WorkoutCard(
                        title: 'Ladders',
                        description: '5 ladders: 1, 2, 3... with 30sec rest',
                        icon: const Icon(
                          Icons.trending_up,
                          color: Colors.white,
                          size: 27,
                        ),
                        isSelected: _selected == WorkoutType.ladders,
                        onTap: () =>
                            setState(() => _selected = WorkoutType.ladders),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.cardGap),

                // Start workout button
                GradientButton(
                  text: 'Start Workout',
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: _handleSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          // App title
          Text(
            AppConstants.appTitle,
            style: AppTypography.displayLarge,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppSpacing.sm),

          // Subtitle - centered
          Text(
            'The plan for doubling your max pull ups!',
            style: AppTypography.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
