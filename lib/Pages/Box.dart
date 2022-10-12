import 'package:flutter/material.dart';

class Box extends StatefulWidget {
  final double boxXAxis;
  final double boxYAxis;
  final double height;

  final double width;
  const Box(
      {super.key,
      required this.boxXAxis,
      required this.boxYAxis,
      required this.height,
      required this.width});

  @override
  State<Box> createState() => _BoxState();
}

class _BoxState extends State<Box> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment(widget.boxXAxis, widget.boxYAxis),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Image.asset(
          "assets/images/box.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
