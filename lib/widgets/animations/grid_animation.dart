import 'package:flutter/material.dart';

class GridAnimation extends StatefulWidget {
  const GridAnimation({super.key});

  @override
  State<GridAnimation> createState() => _GridAnimationState();
}

class _GridAnimationState extends State<GridAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        itemCount: 100,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          // crossAxisSpacing: 5,
          // mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
