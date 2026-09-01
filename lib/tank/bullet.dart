import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class Bullet extends StatefulWidget {
  final Alignment bulletPosition;
  final double angle;
  final ValueChanged<int> endBullet;
  final int index;
  const Bullet({
    required this.index,
    required this.endBullet,
    required this.angle,
    required this.bulletPosition,
    super.key,
  });

  @override
  State<Bullet> createState() => _BulletState();
}

class _BulletState extends State<Bullet> {
  late Alignment bStartingPoint = widget.bulletPosition;
  late double bAngle = widget.angle;
  late Duration speed = Duration(milliseconds: 100);
  late double stepSize = 0.03;
  late double bx;
  late double by;
  late double maxBulletField = 1.3;
  late double shellSize = 10;
  Timer? gameLoopTimer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bx = bStartingPoint.x;
    by = bStartingPoint.y;
    gameLoopTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      move();
    });
  }

  @override
  void dispose() {
    gameLoopTimer?.cancel();
    super.dispose();
  }

  void move() {
    setState(() {
      by -= (cos(bAngle) * (stepSize));
      bx += (sin(bAngle) * (stepSize));

      by = by.clamp(-maxBulletField, maxBulletField);
      bx = bx.clamp(-maxBulletField, maxBulletField);

      if (by >= maxBulletField ||
          by <= -maxBulletField ||
          bx <= -maxBulletField ||
          bx >= maxBulletField) {
        gameLoopTimer?.cancel();
        widget.endBullet(widget.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: Alignment(bx, by),
      duration: speed,
      curve: Curves.linear,

      child: Container(
        width: shellSize,
        height: shellSize,

        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      ),
    );
  }
}
