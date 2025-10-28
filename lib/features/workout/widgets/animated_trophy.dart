import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pull_up_ritual/common/themes/app_colors.dart';

class AnimatedTrophy extends StatefulWidget {
  final double size;
  const AnimatedTrophy({super.key, this.size = 112});

  @override
  State<AnimatedTrophy> createState() => _AnimatedTrophyState();
}

class _AnimatedTrophyState extends State<AnimatedTrophy>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _rotation;
  late final Animation<double> _glowOpacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scale = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.9, curve: Curves.elasticOut),
    ).drive(Tween(begin: 0.6, end: 1.0));

    _rotation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
    ).drive(Tween(begin: -0.12, end: 0.0));

    _glowOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    );

    // Kick off animation on first frame.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double s = widget.size;
    const Color trophyColor = AppColors.yellow;

    return SizedBox(
      width: s,
      height: s,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Soft blurred glow behind the trophy
          FadeTransition(
            opacity: _glowOpacity,
            child: Container(
              width: s,
              height: s,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    trophyColor.withValues(alpha: 0.55),
                    trophyColor.withValues(alpha: 0.0),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: trophyColor.withValues(alpha: 0.45),
                    blurRadius: s * 0.35,
                    spreadRadius: s * 0.05,
                  ),
                ],
              ),
            ),
          ),
          // Main trophy badge
          ScaleTransition(
            scale: _scale,
            child: AnimatedBuilder(
              animation: _rotation,
              builder: (context, child) {
                return Transform.rotate(angle: _rotation.value, child: child);
              },
              child: Container(
                width: s * 0.86,
                height: s * 0.86,
                decoration: BoxDecoration(
                  color: trophyColor.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.emoji_events_rounded,
                  color: Colors.orange.shade900.withValues(alpha: 0.85),
                  size: s * 0.46,
                ),
              ),
            ),
          ),
          // A few playful sparkle dots that fade in
          Positioned(
            right: s * 0.08,
            top: s * 0.18,
            child: _Sparkle(opacity: _glowOpacity, size: s * 0.08, angle: 0),
          ),
          Positioned(
            left: s * 0.12,
            top: s * 0.28,
            child: _Sparkle(
              opacity: _glowOpacity,
              size: s * 0.06,
              angle: math.pi / 4,
            ),
          ),
          Positioned(
            left: s * 0.2,
            bottom: s * 0.14,
            child: _Sparkle(
              opacity: _glowOpacity,
              size: s * 0.07,
              angle: -math.pi / 6,
            ),
          ),
        ],
      ),
    );
  }
}

class _Sparkle extends StatelessWidget {
  final Animation<double> opacity;
  final double size;
  final double angle;

  const _Sparkle({
    required this.opacity,
    required this.size,
    required this.angle,
  });

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: opacity,
      child: Transform.rotate(
        angle: angle,
        child: Icon(
          Icons.star_rounded,
          color: AppColors.gold.withValues(alpha: 0.9),
          size: size,
        ),
      ),
    );
  }
}
