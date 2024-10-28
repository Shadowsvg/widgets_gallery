import 'package:flutter/material.dart';

class PulsatingCircleAnimation extends StatefulWidget {
  const PulsatingCircleAnimation({
    super.key,
    this.circleColor = Colors.purple,
    this.duration = const Duration(milliseconds: 1500),
  });

  final Color circleColor;
  final Duration duration;

  @override
  State<PulsatingCircleAnimation> createState() =>
      _PulsatingCircleAnimationState();
}

class _PulsatingCircleAnimationState extends State<PulsatingCircleAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _secondAnimationController;
  late Animation<double> _radiusAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _radiusAnimationForSecond;
  late Animation<double> _opacityAnimationForSecond;
  bool secondCircleStarted = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _secondAnimationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _radiusAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 10, end: 40), weight: 45),
      TweenSequenceItem(tween: Tween<double>(begin: 40, end: 40), weight: 40),
      TweenSequenceItem(tween: Tween<double>(begin: 40, end: 50), weight: 15),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    _opacityAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 45),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 40),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 15),
    ]).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    _radiusAnimationForSecond = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 10, end: 40), weight: 45),
      TweenSequenceItem(tween: Tween<double>(begin: 40, end: 40), weight: 40),
      TweenSequenceItem(tween: Tween<double>(begin: 40, end: 50), weight: 15),
    ]).animate(
      CurvedAnimation(
        parent: _secondAnimationController,
        curve: Curves.ease,
      ),
    );

    _opacityAnimationForSecond = TweenSequence([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 45),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 40),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 15),
    ]).animate(
      CurvedAnimation(
        parent: _secondAnimationController,
        curve: Curves.ease,
      ),
    );

    _animationController.repeat();

    _animationController.addListener(() {
      if (_radiusAnimation.value > 40 && !secondCircleStarted) {
        secondCircleStarted = true;
        _secondAnimationController.repeat();
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _secondAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              width: _radiusAnimation.value,
              height: _radiusAnimation.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      widget.circleColor.withOpacity(_opacityAnimation.value),
                ),
              ),
            );
          },
        ),
        if (secondCircleStarted)
          AnimatedBuilder(
            animation: _secondAnimationController,
            builder: (context, child) {
              return Container(
                width: _radiusAnimationForSecond.value,
                height: _radiusAnimationForSecond.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.circleColor.withOpacity(
                      _opacityAnimationForSecond.value,
                    ),
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
