import 'package:flutter/material.dart';
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
            TankBody(tx: tx.clamp(-1, 1), ty: ty.clamp(-1, 1)),
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
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
