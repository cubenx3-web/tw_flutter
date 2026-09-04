import 'package:flutter/material.dart';
import 'package:tw_flutter/tank/controller/buttonDirections.dart';
import 'package:tw_flutter/tank/controller/joyStick.dart';
import 'package:tw_flutter/tank/controller/shootButton.dart';

// import 'package:tw_flutter/tank/controller/joyStick.dart';

class Controller extends StatefulWidget {
  final  ValueChanged<Alignment> inputData;
  final ValueChanged<bool> shootData;

  const Controller({
    required this.inputData,
    required this.shootData,
    super.key,
  });

  @override
  State<Controller> createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  String selectedController = "d";
  late Map controllerType = {
      "a": {
        "directions": Joystick(
          position: Alignment(-0.8, 0.6),
          inputData: widget.inputData,
        ),
        "shoot": Shootbutton(
          position: Alignment(0.8, 0.9),
          shootData: widget.shootData,
        ),
      },

      "b": {
        "directions": Joystick(
          position: Alignment(0.8, 0.6),
          inputData: widget.inputData,
        ),
        "shoot": Shootbutton(
          position: Alignment(-0.8, 0.9),
          shootData: widget.shootData,
        ),
      },

      "c": {
        "directions": ButtonDirections(
          position: Alignment(-0.8, 0.9),
          inputData: widget.inputData,
        ),
        "shoot": Shootbutton(
          position: Alignment(0.8, 0.9),
          shootData: widget.shootData,
        ),
      },

      "d": {
        "directions": ButtonDirections(
          position: Alignment(1, 1),
          inputData: widget.inputData,
        ),
        "shoot": Shootbutton(
          position: Alignment(-1, 1),
          shootData: widget.shootData,
        ),
      },
    };

  @override
  Widget build(BuildContext context) {
    


    return Stack(
      children: [
        controllerType[selectedController]["directions"],
        controllerType[selectedController]["shoot"],
        
      ],
    );
  }
}
