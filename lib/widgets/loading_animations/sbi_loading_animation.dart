import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widgets_gallery/custom_page_route.dart';
import 'package:widgets_gallery/widgets/loading_animations/success_animation.dart';

class SBILoadingAnimation extends StatefulWidget {
  const SBILoadingAnimation({super.key});

  @override
  State<SBILoadingAnimation> createState() => _SBILoadingAnimationState();
}

class _SBILoadingAnimationState extends State<SBILoadingAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _secondAnimationController;
  late AnimationController _textAnimationController;
  late Animation<double> _radiusAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _radiusAnimationForSecond;
  late Animation<double> _opacityAnimationForSecond;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textOpacityAnimation;
  bool secondCircleStarted = false;
  bool isAnimated = false;

  String processingText = 'Processing payment';
  String processingTextSecond = 'Waiting for confirmation';

  Widget _initialWidget = const CircularProgressIndicator(
    color: Colors.white,
  );

  Widget _initialWidgetTwo = const CircularProgressIndicator(
    color: Colors.white,
  );

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );

    _secondAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1500,
      ),
    );

    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
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

    _textSlideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(
      _textAnimationController,
    );

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      _textAnimationController,
    );

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
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 5,
          ),
          SizedBox(
            width: double.infinity,
            height: 100,
            child: Stack(
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
                              Colors.white.withOpacity(_opacityAnimation.value),
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
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Transaction in progress',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Text(
            'Please wait...',
            style: TextStyle(
              color: Color.fromARGB(224, 238, 230, 230),
              fontSize: 16,
            ),
          ),
          const Spacer(
            flex: 3,
          ),
          SlideTransition(
            position: _textSlideAnimation,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _textAnimationController.forward();
                  processingText = 'Payment processed';
                  _initialWidget = const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  );
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 16,
                    width: 16,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: _initialWidget,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Text(
                      processingText, // changes to 'Payment processed'
                      key: ValueKey<String>(
                        processingText,
                      ), // passing key is important when animated widget is same
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SlideTransition(
            position: _textSlideAnimation,
            child: FadeTransition(
              opacity: _textOpacityAnimation,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _initialWidgetTwo = const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    );
                    processingTextSecond = 'Transaction Confirmed';
                  });
                  Timer(
                      const Duration(
                        milliseconds: 500,
                      ), () {
                    Navigator.push(
                      context,
                      CustomPageRoute(
                        route: const SuccessAnimation(),
                      ),
                    );
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 16,
                      width: 16,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: _initialWidgetTwo,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: Text(
                        processingTextSecond, // changes to 'Payment processed'
                        key: ValueKey<String>(
                          processingTextSecond,
                        ), // passing key is important when animated widget is same
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
