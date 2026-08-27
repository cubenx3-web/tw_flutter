import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ButtonDirections extends StatefulWidget {
  final ValueChanged<Alignment> inputData;
  const ButtonDirections({required this.inputData, super.key});

  @override
  State<ButtonDirections> createState() => _ButtonDirectionsState();
}

class _ButtonDirectionsState extends State<ButtonDirections> {
  late double buttonsContainer = 150;

  late List buttons = [
    {
      "direction": Icon(Icons.arrow_upward, color: Colors.white),
      "alignment": Alignment(0, -1),
    },
    {
      "direction": Icon(Icons.arrow_downward, color: Colors.white),
      "alignment": Alignment(0, 1),
    },
    {
      "direction": Icon(Icons.arrow_back, color: Colors.white),
      "alignment": Alignment(-1, 0),
    },
    {
      "direction": Icon(Icons.arrow_forward, color: Colors.white),
      "alignment": Alignment(1, 0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-0.8, 0.95),

      child: Container(
        width: buttonsContainer,
        height: buttonsContainer,

        decoration: BoxDecoration(
          color: const Color.fromARGB(26, 255, 255, 255),
          shape: BoxShape.circle,
        ),

        child: Stack(
          children: buttons.map((b) {
            return Align(
              alignment: b["alignment"],
              child: GestureDetector(
                onPanStart: (d){
                  widget.inputData(b["alignment"]);
                },
                
                onPanUpdate: (d){
                  widget.inputData(b["alignment"]);
                },

                onPanCancel: (){
                  widget.inputData(Alignment(0, 0));
                },

                onPanEnd: (d){
                  widget.inputData(Alignment(0, 0));
                },

                child: Container(
                  width: 50,
                  height: 50,

                  decoration: BoxDecoration(
                    color: const Color.fromARGB(75, 3, 168, 244),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: b["direction"]),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
