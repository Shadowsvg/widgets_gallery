import 'package:flutter/material.dart';

class ZomatoTextField extends StatefulWidget {
  const ZomatoTextField({super.key});

  @override
  State<ZomatoTextField> createState() => _ZomatoTextFieldState();
}

class _ZomatoTextFieldState extends State<ZomatoTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            color: Color(0xffE95161),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              'Search "Ice Cream"',
              style: TextStyle(color: Color(0xff767C8F), fontSize: 16),
            ),
          ),
          VerticalDivider(
            endIndent: 5,
            indent: 5,
          ),
          Icon(
            Icons.mic_none_outlined,
            color: Color(0xffE95161),
          ),
        ],
      ),
    );
    // TextField(
    //   controller: TextEditingController(),
    //   showCursor: false,

    //   decoration: const InputDecoration(
    //       contentPadding: EdgeInsets.all(4),
    //       hintText: 'Search "Ice Cream"',
    //       border: OutlineInputBorder(

    //         borderRadius: BorderRadius.all(Radius.circular(16)),
    //       ),
    //       prefixIcon: Icon(
    //         Icons.search,
    //       ),
    //       suffixIcon: Row(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Icon(Icons.mic),
    //         ],
    //       )),
    // );
  }
}


// Icon color : #E95161
