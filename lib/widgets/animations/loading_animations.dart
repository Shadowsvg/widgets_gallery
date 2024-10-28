import 'package:flutter/material.dart';
import 'package:widgets_gallery/widgets/animations/loading_animation_list.dart';

class LoadingAnimations extends StatefulWidget {
  const LoadingAnimations({super.key});

  @override
  State<LoadingAnimations> createState() => _LoadingAnimationsState();
}

class _LoadingAnimationsState extends State<LoadingAnimations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: _getWidgetInRatio(),
        ),
      ),
    );
  }

  List<Widget> _getWidgetInRatio() {
    List<Widget> list = [];
    for (int i = 0; i < loadingAnimationList.length; i++) {
      if (i % 3 == 2) {
        list.add(
          Row(
            children: [
              Expanded(
                child: LoadingWidgetCard(child: loadingAnimationList[i]),
              ),
            ],
          ),
        );
      } else {
        list.add(
          Row(
            children: [
              Expanded(
                child: LoadingWidgetCard(child: loadingAnimationList[i]),
              ),
              Expanded(
                child: LoadingWidgetCard(child: loadingAnimationList[i + 1]),
              ),
            ],
          ),
        );
        i += 1;
      }
    }
    return list;
  }
}

class LoadingWidgetCard extends StatelessWidget {
  const LoadingWidgetCard({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      height: screenHeight / 3,
      child: child,
    );
  }
}
