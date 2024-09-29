import 'package:flutter/material.dart';
import 'package:widgets_gallery/base_scaffold.dart';

class ButtonAnimation extends StatefulWidget {
  const ButtonAnimation({super.key});

  @override
  State<ButtonAnimation> createState() => _ButtonAnimationState();
}

class _ButtonAnimationState extends State<ButtonAnimation> {
  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isTapped = !isTapped;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            height: 54,
            width: isTapped ? 54 : 500,
            decoration: BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.circular(
                27,
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.ease,
                switchOutCurve: Curves.ease,
                child: isTapped
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'Tap me',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
