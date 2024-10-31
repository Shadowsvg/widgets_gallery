import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widgets_gallery/custom_page_route.dart';
import 'package:widgets_gallery/widgets/animations/pulsating_loading_animation.dart';
import 'package:widgets_gallery/widgets/animations/success_animation.dart';

class TransactionAnimation extends StatefulWidget {
  const TransactionAnimation({super.key});

  @override
  State<TransactionAnimation> createState() => _TransactionAnimationState();
}

class _TransactionAnimationState extends State<TransactionAnimation>
    with TickerProviderStateMixin {
  late AnimationController _textAnimationController;
  late AnimationController _columnAnimationController;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textOpacityAnimation;

  String processingText = 'Preparing for action...';
  String processingTextSecond = 'Getting ready for a smooth transition...';

  Widget _initialWidget = const CircularProgressIndicator(
    color: Colors.white,
  );

  Widget _initialWidgetTwo = const CircularProgressIndicator(
    color: Colors.white,
  );

  @override
  void initState() {
    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    _columnAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    _textSlideAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -1)).animate(
      _textAnimationController,
    );

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      _textAnimationController,
    );

    Timer(const Duration(milliseconds: 2000), () {
      _textAnimationController.forward();
      setState(() {
        processingText = 'Everything’s in motion!';
        _initialWidget = const Icon(
          Icons.check_circle,
          color: Color(0xFF065606),
        );
      });
    });

    _textAnimationController.addListener(() {
      if (_textAnimationController.isCompleted) {
        Timer(const Duration(milliseconds: 2000), () {
          setState(() {
            _initialWidgetTwo = const Icon(
              Icons.check_circle,
              color: Color(0xFF065606),
            );
            processingTextSecond = 'Bringing visuals to life...';
          });
          Future.delayed(
              const Duration(
                milliseconds: 750,
              ), () {
            _columnAnimationController.forward();
          });
        });
      }
    });

    _columnAnimationController.addListener(() {
      if (_columnAnimationController.isCompleted) {
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
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    _columnAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF051F3A),
      body: FadeTransition(
        opacity: Tween<double>(begin: 1, end: 0).animate(
          _columnAnimationController,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 5,
            ),
            const SizedBox(
              height: 100,
              child: PulsatingCircleAnimation(
                circleColor: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Animating your experience...',
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
            const SizedBox(
              height: 30,
            ),
            SlideTransition(
              position: _textSlideAnimation,
              child: FadeTransition(
                opacity: _textOpacityAnimation,
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
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
