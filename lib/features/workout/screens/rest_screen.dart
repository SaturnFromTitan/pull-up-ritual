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
import 'dart:math' as math;

class RestScreen extends StatelessWidget {
  const RestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var workoutProvider = context.watch<WorkoutProvider>();

    if (!workoutProvider.isResting()) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pop(context),
      );
    }

    return ScreenScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(workoutProvider.workout.workoutType.name),
          _RestTimerRing(),
          GradientButton(
            onPressed: () {
              workoutProvider.resume();
              // no need to call Navigator.pop(...) here as the state change
              // causes this function to rerun and call the same code that
              // would run if the timer reached 0.
            },
            text: "Skip Rest",
            icon: Icon(Icons.skip_next),
            gradient: AppGradients.secondary,
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

class _RestTimerRing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workoutProvider = context.watch<WorkoutProvider>();

    final total = workoutProvider.restTotalSeconds;
    final remaining = workoutProvider.restTimeRemaining;
    final value = (total <= 0)
        ? 0.0
        : (total - remaining).clamp(0, total) / total;

    const double size = 220;
    const double ringThickness = 14;

    return Column(
      children: [
        SizedBox(
          height: size,
          width: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // background ring (glass)
              CustomPaint(
                size: const Size.square(size),
                painter: _RingPainter(
                  progress: 1.0,
                  thickness: ringThickness,
                  color: AppColors.glassBorderInactive,
                ),
              ),
              // gradient progress ring
              CustomPaint(
                size: const Size.square(size),
                painter: _RingPainter(
                  progress: value,
                  thickness: ringThickness,
                  gradient: AppGradients.primary,
                ),
              ),
              // center content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '😴',
                    style: AppTypography.displayMedium.copyWith(fontSize: 64),
                  ),
                  SizedBox(height: AppSpacing.lg),
                  Text(
                    formatMinutesSeconds(remaining),
                    style: AppTypography.displayMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress; // 0..1
  final double thickness;
  final LinearGradient? gradient;
  final Color? color;

  _RingPainter({
    required this.progress,
    required this.thickness,
    this.gradient,
    this.color,
  }) : assert(((gradient == null) != (color == null)));

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = (math.min(size.width, size.height) - thickness) / 2;
    final startAngle = -math.pi / 2; // start at top
    final sweepAngle = 2 * math.pi * progress.clamp(0.0, 1.0);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round;

    if (gradient != null) {
      paint.shader = SweepGradient(
        colors: gradient!.colors,
        startAngle: 0.0,
        endAngle: 2 * math.pi,
        transform: GradientRotation(startAngle),
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    } else {
      paint.color = color!;
    }

    // Draw arc
    final rectForArc = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rectForArc, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
