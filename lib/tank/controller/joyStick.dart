import 'dart:math';

import 'package:flutter/material.dart';

class Joystick extends StatefulWidget {
  final  ValueChanged<Alignment> inputData;
  const Joystick({required this.inputData, super.key});

  @override
  State<Joystick> createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  late double controllerSize = 100;
  late double jx = 0;
  late double jy = 0;
  late double r = 2;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.8, 0.6),

      child: Container(
        width: controllerSize,
        height: controllerSize,

        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(83, 255, 255, 255)),
          shape: BoxShape.circle,
          color: const Color.fromARGB(45, 240, 239, 239),
        ),

        child: Align(
          alignment: Alignment(jx, jy),

          child: GestureDetector(
            onPanStart: (details) {
              print("Start moving");
            },

            onPanUpdate: (details) {
              setState(() {
                jx += details.delta.dx / controllerSize * 2;
                jy += details.delta.dy / controllerSize * 2;

                jx = jx.clamp(
                  -(sqrt(-pow(jy.clamp(-2, 2), 2) + pow(r, 2))),
                  sqrt(-pow(jy.clamp(-2, 2), 2) + pow(r, 2)),
                );
                jy = jy.clamp(
                  -(sqrt(-pow(jx.clamp(-2, 2), 2) + pow(r, 2))),
                  sqrt(-pow(jx.clamp(-2, 2), 2) + pow(r, 2)),
                );

                widget.inputData( Alignment(jx, jy));
              });
            },

            onPanCancel: () {
              setState(() {
                jx = 0;
                jy = 0;
                widget.inputData( Alignment(jx, jy));
              });
            },

            onPanEnd: (detail) {
              setState(() {
                jx = 0;
                jy = 0;
                widget.inputData( Alignment(jx, jy));
              });
            },

            child: Container(
              width: controllerSize / 2,
              height: controllerSize / 2,

              decoration: BoxDecoration(
                color: const Color.fromARGB(135, 33, 149, 243),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
