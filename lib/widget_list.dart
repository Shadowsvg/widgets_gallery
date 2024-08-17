import 'package:flutter/material.dart';
import 'package:widgets_gallery/widgets/buttons/buttons_list.dart';
import 'package:widgets_gallery/widgets/buttons/normal_button.dart';
import 'package:widgets_gallery/widgets/textfields/textfields_list.dart';

class WidgetList extends StatelessWidget {
  const WidgetList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(21),
          child: Column(
            children: [
              NormalButton(label: 'Buttons', onTapWidget: ButtonsList()),
              SizedBox(
                height: 20,
              ),
              NormalButton(
                label: 'TextFields',
                onTapWidget: TextFieldsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
