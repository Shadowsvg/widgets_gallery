import 'package:flutter/material.dart';
import 'package:widgets_gallery/base_scaffold.dart';
import 'package:widgets_gallery/widgets/buttons/normal_button.dart';

class ButtonsList extends StatelessWidget {
  const ButtonsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      body: Column(
        children: [
          NormalButton(label: 'Normal Button'),
        ],
      ),
    );
  }
}
