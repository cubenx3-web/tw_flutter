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
  late double roomWidth = 600;
  late double roomHeight = 300;
  late bool shooting = false;
  late double tankAngle = 0.0;
  late Offset tankPosition = Offset(0, 0);

  late double tankSize = 20;
  late double shellSize = tankSize/3;

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
        child: Container(
          width: roomWidth,
          height: roomHeight,

          

          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(20),
          ),

          child: Stack(
            children: [
              Stack(children: bullets.values.toList()),
              TankBody(
                tankSize: tankSize,
                roomHeight: roomHeight,
                roomWidth: roomWidth,
                tx: tx,
                ty: ty,
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
                        tankSize: tankSize,
                        shellSize: shellSize,
                        roomHeight: roomHeight,
                        roomWidth: roomWidth,
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
                        tankSize: tankSize,
                        shellSize: shellSize,
                        roomWidth: roomWidth,
                        roomHeight: roomHeight,
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
            ],
          ),
        ),
      ),
    );
  }
}
