import 'package:flutter/material.dart';
import 'package:tw_flutter/tank/controller/buttonDirections.dart';
import 'package:tw_flutter/tank/controller/shootButton.dart';

// import 'package:tw_flutter/tank/controller/joyStick.dart';

class Controller extends StatefulWidget {
  final ValueChanged<Alignment> inputData;
  final ValueChanged<bool> shootData;

  const Controller({required this.inputData, required this.shootData,super.key});

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Joystick(inputData: widget.inputData)
        ButtonDirections(inputData: widget.inputData),
        Shootbutton(shootData: widget.shootData,),
      ],
    );
  }
}
