import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:widgets_gallery/custom_page_route.dart';

class AlarmAnimation extends StatefulWidget {
  const AlarmAnimation({super.key});

  @override
  State<AlarmAnimation> createState() => _AlarmAnimationState();
}

class _AlarmAnimationState extends State<AlarmAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212228),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          padding: const EdgeInsets.all(8),
          height: 110,
          decoration: BoxDecoration(
            color: const Color(0xFF2f363e),
            borderRadius: BorderRadius.circular(
              55,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DragTarget<String>(
                onAcceptWithDetails: (details) {
                  if (details.data == 'alarm') {
                    Navigator.push(
                      context,
                      CustomPageRoute(
                        route: const AlarmChoiceScreen(
                          alarmChoice: 'Snooze',
                        ),
                      ),
                    );
                  }
                },
                onMove: (details) {
                  // if (details.data == 'alarm') {
                  //   Navigator.push(
                  //     context,
                  //     CustomPageRoute(
                  //       route: const AlarmChoiceScreen(
                  //         alarmChoice: 'Snooze',
                  //       ),
                  //     ),
                  //   );
                  // }
                },
                builder: (
                  BuildContext context,
                  List<Object?> candidateData,
                  List<dynamic> rejectedData,
                ) {
                  return Container(
                    width: 120,
                    padding: const EdgeInsets.only(left: 8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(55),
                        bottomLeft: Radius.circular(55),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Snooze',
                        style: TextStyle(
                          color: Color(0xffe4e8f1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
              ),
              Draggable<String>(
                data: 'alarm',
                hitTestBehavior: HitTestBehavior.deferToChild,
                feedback: const AlarmContainer(),
                childWhenDragging: Container(
                  color: Colors.transparent,
                ),
                axis: Axis.horizontal,
                child: const AlarmContainer(),
              ),
              DragTarget<String>(
                onAcceptWithDetails: (details) {
                  if (details.data == 'alarm') {
                    Navigator.push(
                      context,
                      CustomPageRoute(
                        route: const AlarmChoiceScreen(
                          alarmChoice: 'Stop',
                        ),
                      ),
                    );
                  }
                },
                builder: (
                  BuildContext context,
                  List<Object?> candidateData,
                  List<dynamic> rejectedData,
                ) {
                  return Container(
                    padding: const EdgeInsets.only(right: 8),
                    width: 120,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(55),
                        bottomRight: Radius.circular(55),
                      ),
                    ),
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Stop',
                        style: TextStyle(
                          color: Color(0xffe4e8f1),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AlarmContainer extends StatefulWidget {
  const AlarmContainer({super.key});

  @override
  State<AlarmContainer> createState() => _AlarmContainerState();
}

class _AlarmContainerState extends State<AlarmContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _alarmController;
  late Animation<double> _alarmAnimation;

  @override
  void initState() {
    super.initState();
    _alarmController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );
    _alarmAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _alarmController,
        curve: Curves.elasticIn,
      ),
    );
    _alarmController.repeat(
      reverse: true,
    );
  }

  @override
  void dispose() {
    _alarmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      width: 120,
      decoration: BoxDecoration(
        color: const Color(0xFF005692),
        borderRadius: BorderRadius.circular(
          55,
        ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _alarmAnimation,
          child: const Icon(
            Icons.alarm,
            color: Color(0xffd7e6fa),
          ),
          builder: (context, child) {
            return Transform.rotate(
              angle: (math.pi / 9) * _alarmAnimation.value,
              alignment: Alignment.center,
              child: child,
            );
          },
        ),
      ),
    );
  }
}

class AlarmChoiceScreen extends StatelessWidget {
  const AlarmChoiceScreen({
    super.key,
    required this.alarmChoice,
  });
  final String alarmChoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212228),
      body: Center(
        child: Text(
          alarmChoice,
          style: const TextStyle(
            color: Color(0xffe4e8f1),
            fontSize: 32,
          ),
        ),
      ),
    );
  }
}
