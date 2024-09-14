import 'package:flutter/material.dart';
import 'package:widgets_gallery/base_scaffold.dart';

class SBILoadingAnimation extends StatefulWidget {
  const SBILoadingAnimation({super.key});

  @override
  State<SBILoadingAnimation> createState() => _SBILoadingAnimationState();
}

class _SBILoadingAnimationState extends State<SBILoadingAnimation>
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
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
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

    _secondAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
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

    _animationController.addListener(() {
      if (_radiusAnimation.value > 40 && !secondCircleStarted) {
        secondCircleStarted = true;
        _secondAnimationController.repeat();
        setState(() {});
      }
    });

    _animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _secondAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      color: Colors.purple,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
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
                            color: Colors.white
                                .withOpacity(_opacityAnimation.value),
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
                              color: Colors.white.withOpacity(
                                _opacityAnimationForSecond.value,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // const Text(
              //   'Transaction in progress',
              //   style: TextStyle(
              //     color: Colors.white,
              //     fontSize: 20,
              //     fontWeight: FontWeight.w700,
              //   ),
              // ),
              // const Text(
              //   'Please wait...',
              //   style: TextStyle(
              //     color: Color.fromARGB(224, 238, 230, 230),
              //     fontSize: 16,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
