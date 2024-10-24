import 'package:flutter/material.dart';
import 'package:widgets_gallery/base_scaffold.dart';
import 'package:widgets_gallery/widgets/animations/alarm_animation.dart';
import 'package:widgets_gallery/widgets/animations/button_animation.dart';
import 'package:widgets_gallery/widgets/animations/circular_loading_animation.dart';
import 'package:widgets_gallery/widgets/animations/grid_animation.dart';
import 'package:widgets_gallery/widgets/animations/loading_animation.dart';
import 'package:widgets_gallery/widgets/buttons/normal_button.dart';
import 'package:widgets_gallery/widgets/animations/pulsating_circle_animation.dart';

class Animations extends StatelessWidget {
  const Animations({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      body: Column(
        children: [
          NormalButton(
            label: 'Circular Loading Animation',
            onTapWidget: PulsatingCircleAnimation(),
          ),
          SizedBox(
            height: 20,
          ),
          NormalButton(
            label: 'Circular progress animation',
            onTapWidget: LoadingAnimation(),
          ),
          SizedBox(
            height: 20,
          ),
          NormalButton(
            label: 'Button Animation',
            onTapWidget: ButtonAnimation(),
          ),
          SizedBox(
            height: 20,
          ),
          NormalButton(
            label: 'Alarm Animation',
            onTapWidget: AlarmAnimation(),
          ),
          SizedBox(
            height: 20,
          ),
          NormalButton(
            label: 'Grid Animation',
            onTapWidget: GridAnimation(),
          ),
          SizedBox(
            height: 20,
          ),
          NormalButton(
            label: 'Circular Loading Animation',
            onTapWidget: CircularLoadingAnimation(),
          ),
        ],
      ),
    );
  }
}
