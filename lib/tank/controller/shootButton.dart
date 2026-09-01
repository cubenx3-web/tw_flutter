import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Shootbutton extends StatefulWidget {
  final Alignment position;
  final ValueChanged<bool> shootData;
  const Shootbutton({required this.position, required this.shootData, super.key});

  @override
  State<Shootbutton> createState() => _ShootbuttonState();
}

class _ShootbuttonState extends State<Shootbutton> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.position,
      child: GestureDetector(
        onPanStart: (d) {
          setState(() {
            widget.shootData(true);
          });
        },
        
        onPanEnd: (d) {
          setState(() {
            widget.shootData(false);
          });
        },
        onPanCancel: () {
          setState(() {
            widget.shootData(false);
          });
        },

        child: Container(
          width: 100,
          height: 50,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(66, 33, 149, 243),
          ),

          child: Icon(Icons.all_out_outlined, size: 50, color: Colors.white),
        ),
      ),
    );
  }
}
