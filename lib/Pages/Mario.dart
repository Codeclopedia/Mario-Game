import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Mario extends StatefulWidget {
  double marioXAxis;
  double marioYAxis;
  String currentmario;
  bool ismariosmall;
  Mario(
      {super.key,
      required this.marioXAxis,
      required this.marioYAxis,
      required this.currentmario,
      required this.ismariosmall});

  @override
  State<Mario> createState() => _MarioState();
}

class _MarioState extends State<Mario> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment(widget.marioXAxis, widget.marioYAxis),
      child: Image.asset(
        widget.currentmario,
        fit: BoxFit.cover,
        height: widget.ismariosmall
            ? MediaQuery.of(context).size.height * 0.17
            : MediaQuery.of(context).size.height * 0.12,
        width: widget.ismariosmall
            ? MediaQuery.of(context).size.width * 0.07
            : MediaQuery.of(context).size.width * 0.05,
      ),
    );
  }
}
