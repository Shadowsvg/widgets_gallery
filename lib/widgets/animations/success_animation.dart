import 'package:flutter/material.dart';

class SuccessAnimation extends StatefulWidget {
  const SuccessAnimation({super.key});

  @override
  State<SuccessAnimation> createState() => _SuccessAnimationState();
}

class _SuccessAnimationState extends State<SuccessAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  Widget _initialIcon = const Icon(
    Icons.check_circle_outline_rounded,
    color: Colors.white,
    key: ValueKey<int>(1),
  );
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 400,
      ),
      reverseDuration: const Duration(
        milliseconds: 200,
      ),
    );
    _scaleAnimation = Tween<double>(begin: 5, end: 13).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    _animationController.addListener(() {
      if (_animationController.isCompleted) {
        _animationController.reverse();
        setState(() {
          _initialIcon = const Icon(
            Icons.check_circle_rounded,
            color: Colors.white,
            key: ValueKey<int>(2),
          );
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF065606),
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedSwitcher(
            duration: const Duration(
              milliseconds: 200,
            ),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: _initialIcon,
          ),
        ),
      ),
    );
  }
}
