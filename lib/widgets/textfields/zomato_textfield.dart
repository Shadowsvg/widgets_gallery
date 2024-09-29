import 'dart:async';

import 'package:flutter/material.dart';

// class ZomatoTextField extends StatefulWidget {
//   const ZomatoTextField({super.key});

//   @override
//   State<ZomatoTextField> createState() => _ZomatoTextFieldState();
// }

// class _ZomatoTextFieldState extends State<ZomatoTextField>
//     with SingleTickerProviderStateMixin {
//   late AnimationController controller;
//   late Animation<Offset> slideAnimation;
//   // late List<Text> textWidgetList;
//   // final List<String> hintList = ['Ice Cream', 'Samosa', 'Biryani'];
//   @override
//   void initState() {
//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 300),
//     );
//     slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 1.5),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(
//         parent: controller,
//         curve: Curves.ease,
//       ),
//     );
//     Timer(const Duration(milliseconds: 2000), () {
//       controller.forward();
//     });
//     // textWidgetList = List.generate(
//     //     hintList.length,
//     //     (index) => Text(
//     //           hintList[index],
//     //           style: const TextStyle(color: Color(0xff767C8F), fontSize: 16),
//     //         ));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       clipBehavior: Clip.hardEdge,
//       height: 48,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: const BorderRadius.all(Radius.circular(16)),
//         boxShadow: [
//           BoxShadow(
//             blurRadius: 2,
//             color: Colors.grey.withOpacity(0.2),
//             offset: const Offset(0, 0),
//             spreadRadius: 3,
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       child: Row(
//         children: [
//           const Icon(
//             Icons.search,
//             color: Color(0xffE95161),
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           Expanded(
//             child: SlideTransition(
//               position: slideAnimation,
//               child: const Text(
//                 'Search "Ice Cream"',
//                 style: TextStyle(color: Color(0xff767C8F), fontSize: 16),
//               ),
//             ),
//           ),
//           // Expanded(
//           //   child: Container(
//           //     // color: Colors.red,
//           //     child: Column(
//           //       crossAxisAlignment: CrossAxisAlignment.start,
//           //       children: [...textWidgetList],
//           //     ),
//           //   ),
//           // ),
//           const VerticalDivider(
//             endIndent: 5,
//             indent: 5,
//           ),
//           const Icon(
//             Icons.mic_none_outlined,
//             color: Color(0xffE95161),
//           ),
//         ],
//       ),
//     );
//     // TextField(
//     //   controller: TextEditingController(),
//     //   showCursor: false,

//     //   decoration: const InputDecoration(
//     //       contentPadding: EdgeInsets.all(4),
//     //       hintText: 'Search "Ice Cream"',
//     //       border: OutlineInputBorder(

//     //         borderRadius: BorderRadius.all(Radius.circular(16)),
//     //       ),
//     //       prefixIcon: Icon(
//     //         Icons.search,
//     //       ),
//     //       suffixIcon: Row(
//     //         mainAxisSize: MainAxisSize.min,
//     //         children: [
//     //           Icon(Icons.mic),
//     //         ],
//     //       )),
//     // );
//   }
// }

// // Icon color : #E95161

class ZomatoTextField extends StatefulWidget {
  const ZomatoTextField({super.key});

  @override
  State<ZomatoTextField> createState() => _ZomatoTextFieldState();
}

class _ZomatoTextFieldState extends State<ZomatoTextField>
    with SingleTickerProviderStateMixin {
  late ScrollController controller = ScrollController();
  // late List<Text> textWidgetList;
  final List<String> hintList = ['Biriyani 😁', 'Ice Cream', 'Samosa'];

  late Timer timer;
  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      controller.animateTo(
        timer.tick % hintList.length * 48,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, 0),
            spreadRadius: 3,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xffE95161)),
          const SizedBox(width: 8),
          Expanded(
            child: ListWheelScrollView(
              itemExtent: 48,
              diameterRatio: 10.0,
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              children: hintList
                  .map(
                    (e) => Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e,
                        style: const TextStyle(
                          color: Color(0xff767C8F),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const VerticalDivider(endIndent: 5, indent: 5),
          const Icon(Icons.mic_none_outlined, color: Color(0xffE95161)),
        ],
      ),
    );
  }
}
