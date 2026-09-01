import 'package:flutter/material.dart';
import 'package:tw_flutter/tank/bullet.dart';
import 'package:tw_flutter/tank/controller/controller.dart';
import 'package:tw_flutter/tank/tankBody.dart';

class RoomA extends StatefulWidget {
  const RoomA({super.key});

  @override
  State<RoomA> createState() => _RoomAState();
}

class _RoomAState extends State<RoomA> {
  late double tx = 0;
  late double ty = 0;
  late bool shooting = false;
  late double tankAngle = 0.0;
  late Alignment tankPosition = Alignment(0, 0);

  late int bulletsShot = 0;
  final Map<int, Bullet> bullets = <int, Bullet>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      persistentFooterDecoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2.3),
      ),

      body: Center(
        child: Stack(
          children: [
            TankBody(
              tx: tx.clamp(-1, 1),
              ty: ty.clamp(-1, 1),
              tankAngle: (angle) {
                setState(() {
                  tankAngle = angle;
                });
              },
              tankPosition: (position) {
                setState(() {
                  tankPosition = position;
                });
              },
              shoot: (isShooting) {
                setState(() {
                  shooting = isShooting;
                  if (shooting) {
                    bullets[bulletsShot] = Bullet(
                      index: bulletsShot,
                      angle: tankAngle,
                      bulletPosition: tankPosition,
                      key: ValueKey(bulletsShot),
                      endBullet: (int index) {
                        setState(() {
                          bullets.remove(index);
                        });
                      },
                    );
                    bulletsShot++;
                  }
                });
              },
            ),

            Controller(
              inputData: (position) {
                setState(() {
                  tx = position.x;
                  ty = position.y;
                });
              },
              shootData: (isShooting) {
                setState(() {
                  shooting = isShooting;
                  if (shooting) {
                    bullets[bulletsShot] = Bullet(
                      index: bulletsShot,
                      angle: tankAngle,
                      bulletPosition: tankPosition,
                      key: ValueKey(bulletsShot),
                      endBullet: (int index) {
                        setState(() {
                          bullets.remove(index);
                        });
                      },
                    );
                    bulletsShot++;
                  }
                });
              },
            ),

            Stack(children: bullets.values.toList()),
          ],
        ),
      ),
    );
  }
}
