import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class TankBody extends StatefulWidget {
  final double tx;
  final double ty;
  final double roomWidth;
  final double roomHeight;
  final double tankSize;
  final ValueChanged<Offset> tankPosition;
  final ValueChanged<double> tankAngle;
  final ValueChanged<bool> shoot;

  const TankBody({
    required this.tankSize,
    required this.shoot,
    required this.roomHeight,
    required this.roomWidth,
    required this.tx,
    required this.ty,
    required this.tankPosition,
    required this.tankAngle,
    super.key,
  });

  @override
  State<TankBody> createState() => _TankBodyState();
}

class _TankBodyState extends State<TankBody> {
  late Offset tankPosition = Offset(0, 0);
  late double tx = (widget.roomWidth - (tankSize * 2)) / 2;
  late double ty = (widget.roomHeight - (tankSize * 2)) / 2;
  late Duration speed = Duration(milliseconds: 50);
  late double tankSize = widget.tankSize;
  late double tankTurn = 0.0;
  late double sharpTurns = 0.03;
  final double stepSize = 3;
  late bool isShoot = false;

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
      }

      if (widget.ty > 0) {
        tx -= (sin(tankTurn) * (widget.ty * stepSize));
        ty += (cos(tankTurn) * (widget.ty * stepSize));
      }

      tankTurn += (widget.tx * 0.05);

      // KEYBOARD
      if (pressedKeys.contains(LogicalKeyboardKey.arrowLeft) ||
          pressedKeys.contains(LogicalKeyboardKey.keyA)) {
        tankTurn -= (sharpTurns);
      }

      if (pressedKeys.contains(LogicalKeyboardKey.arrowRight) ||
          pressedKeys.contains(LogicalKeyboardKey.keyD)) {
        tankTurn += (sharpTurns);
      }

      if (pressedKeys.contains(LogicalKeyboardKey.arrowUp) ||
          pressedKeys.contains(LogicalKeyboardKey.keyW)) {
        ty -= (cos(tankTurn) * (stepSize));
        tx += (sin(tankTurn) * (stepSize));
      }

      if (pressedKeys.contains(LogicalKeyboardKey.arrowDown) ||
          pressedKeys.contains(LogicalKeyboardKey.keyS)) {
        tx -= (sin(tankTurn) * (stepSize));
        ty += (cos(tankTurn) * (stepSize));
      }

      tx = tx.clamp((tankSize/2), widget.roomWidth - ((tankSize *2) - (tankSize/2) ));
      ty = ty.clamp((tankSize/2), widget.roomHeight -((tankSize *2) - (tankSize/2)));

      widget.tankAngle(tankTurn);
      widget.tankPosition(Offset(tx, ty));
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      // alignment: Alignment(tx, ty),

      left: tx,
      top: ty,

      duration: speed,
      curve: Curves.linear,

      child: KeyboardListener(
        focusNode: f,
        onKeyEvent: (event) {
          // print(event.logicalKey.debugName);
          move();

          if (event.logicalKey.debugName.toString().toLowerCase().contains(
            "space",
          )) {
            isShoot = isShoot ? false : true;
            print(isShoot);
            widget.shoot(isShoot);
          }
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

            child: Gun(tankSize: widget.tankSize),
          ),
        ),
      ),
    );
  }
}

class Gun extends StatefulWidget {
  final double tankSize;
  const Gun({ required this.tankSize, super.key});

  @override
  State<Gun> createState() => _GunState();
}

class _GunState extends State<Gun> {
  final FocusNode f = FocusNode();
  List bullets = [];

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
          width: widget.tankSize / 4,
          height: widget.tankSize / 2,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
