import 'package:flutter/material.dart';

class Shells extends StatefulWidget {
  const Shells({super.key});

  @override
  State<Shells> createState() => _ShellsState();
}

class _ShellsState extends State<Shells> {
  late Alignment mStartingPoint = Alignment(0, 0);
  late Duration speed = Duration(milliseconds: 300);

  double shellSize = 20;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: mStartingPoint,
      duration: speed,

      child: Container(
        width: shellSize,
        height: shellSize,

        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),

      ),
    );
  }
}
