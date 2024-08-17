import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({
    super.key,
    this.color,
    required this.label,
    this.onTapWidget,
  });

  final Color? color;
  final String label;
  final Widget? onTapWidget;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(onTapWidget != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => onTapWidget!,));
        } else {
          return;
        }
      },
      child: Container(
      
        height: 48,
        width: 368,
        decoration: BoxDecoration(
            color: color ?? Colors.purple,
            borderRadius: const BorderRadius.all(Radius.circular(8)),),
        child: Center(
            child: Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),),
      ),
    );
  }
}
