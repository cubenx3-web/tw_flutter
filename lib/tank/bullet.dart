import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Bullet extends StatefulWidget {
  final Offset bulletPosition;
  final double angle;
  final double roomWidth;
  final double roomHeight;
  final ValueChanged<int> endBullet;
  final int index;

  const Bullet({
    required this.index,
    required this.roomHeight,
    required this.roomWidth,
    required this.endBullet,
    required this.angle,
    required this.bulletPosition,
    super.key,
  });

  @override
  State<Bullet> createState() => _BulletState();
}

class _BulletState extends State<Bullet> with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  
  late double shellSize = 10;
  late double bx = widget.bulletPosition.dx + (30 / 2) - 5;
  late double by = widget.bulletPosition.dy + (30 / 2) - 5;
  
  late double stepSize = 7.0; 

  late final double minW = -shellSize;
  late final double maxW = widget.roomWidth;
  late final double minH = -shellSize;
  late final double maxH = widget.roomHeight;

  @override
  void initState() {
    super.initState();
    
    // Create a ticker synchronized with the display refresh rate
    _ticker = createTicker((elapsed) {
      move();
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void move() {
    setState(() {
      by -= (cos(widget.angle) * stepSize);
      bx += (sin(widget.angle) * stepSize);

      // Check boundary collision
      if (by >= maxH || by <= minH || bx <= minW || bx >= maxW) {
        _ticker.stop();
        widget.endBullet(widget.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Positioned is much lighter than AnimatedPositioned when updating every frame
    return Positioned(
      left: bx,
      top: by,
      child: Container(
        width: shellSize,
        height: shellSize,
        decoration: const BoxDecoration(
          shape: BoxShape.circle, 
          color: Colors.red,
        ),
      ),
    );
  }
}