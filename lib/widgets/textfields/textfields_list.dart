import 'package:flutter/material.dart';
import 'package:widgets_gallery/base_scaffold.dart';
import 'package:widgets_gallery/widgets/textfields/zomato_textfield.dart';

class TextFieldsList extends StatelessWidget {
  const TextFieldsList({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      body: Column(
        children: [ZomatoTextField()],
      ),
    );
  }
}
