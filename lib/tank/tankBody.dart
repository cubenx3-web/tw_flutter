import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class TankBody extends StatefulWidget {
  final double tx;
  final double ty;

  const TankBody({required this.tx, required this.ty, super.key});

  @override
  State<TankBody> createState() => _TankBodyState();
}

class _TankBodyState extends State<TankBody> {
  late Alignment tankPosition = Alignment(0, 0);
  late double tx = widget.tx;
  late double ty = widget.tx;
  late Duration speed = Duration(milliseconds: 50);
  late double tankSize = 30.0;
  late double tankTurn = 0.0;
  late double sharpTurns = 0.06;
  final double stepSize = 0.008;

  final FocusNode f = FocusNode();
  Timer? gameLoopTimer;

  @override
  void initState() {
    super.initState();
    gameLoopTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      move();
    });
  }

  @override
  void dispose() {
    f.dispose();
    gameLoopTimer?.cancel();
    super.dispose();
  }

  void move() {
    final pressedKeys = HardwareKeyboard.instance.logicalKeysPressed;

    setState(() {
      // MOBILE
      if (widget.ty < 0) {
        ty -= (cos(tankTurn) * (widget.ty * -stepSize));
        tx += (sin(tankTurn) * (widget.ty * -stepSize));

        tx = tx.clamp(-1, 1);
        ty = ty.clamp(-1, 1);
      }

      if (widget.ty > 0) {
        tx -= (sin(tankTurn) * (widget.ty * stepSize));
        ty += (cos(tankTurn) * (widget.ty * stepSize));

        tx = tx.clamp(-1, 1);
        ty = ty.clamp(-1, 1);
      }

      tankTurn += (widget.tx * 0.05);

      // KEYBOARD
      if (pressedKeys.contains(LogicalKeyboardKey.arrowLeft)) {
        tankTurn -= (sharpTurns);
      }

      if (pressedKeys.contains(LogicalKeyboardKey.arrowRight)) {
        tankTurn += (sharpTurns);
      }

      if (pressedKeys.contains(LogicalKeyboardKey.arrowUp)) {
        ty -= (cos(tankTurn) * (stepSize));
        tx += (sin(tankTurn) * (stepSize));

        tx = tx.clamp(-1, 1);
        ty = ty.clamp(-1, 1);
      }

      if (pressedKeys.contains(LogicalKeyboardKey.arrowDown)) {
        tx -= (sin(tankTurn) * (stepSize));
        ty += (cos(tankTurn) * (stepSize));

        tx = tx.clamp(-1, 1);
        ty = ty.clamp(-1, 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: Alignment(tx, ty),

      duration: speed,
      curve: Curves.linear,

      child: KeyboardListener(
        focusNode: f,
        onKeyEvent: (event) {
          // print(event.logicalKey.debugName);
          move();
        },
        child: Transform.rotate(
          angle: tankTurn,
          child: Container(
            width: tankSize,
            height: tankSize,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(tankSize / 15),
              color: Colors.blue,
            ),

            child: Gun(),
          ),
        ),
      ),
    );
  }
}

class Gun extends StatefulWidget {
  const Gun({super.key});

  @override
  State<Gun> createState() => _GunState();
}

class _GunState extends State<Gun> {
  final FocusNode f = FocusNode();

  @override
  void dispose() {
    f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, -2.3),

      child: KeyboardListener(
        focusNode: f,
        autofocus: true,
        onKeyEvent: (event) {},
        child: Container(
          width: 8,
          height: 15,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
