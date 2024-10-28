import 'package:flutter/material.dart';
import 'package:widgets_gallery/base_scaffold.dart';
import 'package:widgets_gallery/widgets/animations/alarm_animation.dart';
import 'package:widgets_gallery/widgets/animations/button_animation.dart';
import 'package:widgets_gallery/widgets/animations/grid_animation.dart';
import 'package:widgets_gallery/widgets/animations/loading_animations.dart';
import 'package:widgets_gallery/widgets/buttons/normal_button.dart';
import 'package:widgets_gallery/widgets/animations/transaction_animation.dart';

class Animations extends StatelessWidget {
  const Animations({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      body: Column(
        children: [
          NormalButton(
            label: 'Loading Animations',
            onTapWidget: LoadingAnimations(),
          ),
          SizedBox(
            height: 20,
          ),
          NormalButton(
            label: 'Transaction Animation',
            onTapWidget: TransactionAnimation(),
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
        ],
      ),
    );
  }
}
