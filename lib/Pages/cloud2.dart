import 'package:flutter/material.dart';

class Clouds extends StatefulWidget {
  double cloudXAxis;
  double cloudYAxis;
  bool changinglocation;

  Clouds({
    super.key,
    required this.cloudXAxis,
    required this.cloudYAxis,
    required this.changinglocation,
  });

  @override
  State<Clouds> createState() => _CloudsState();
}

class _CloudsState extends State<Clouds> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.changinglocation
          ? const Duration(microseconds: 10)
          : const Duration(seconds: 1),
      alignment: Alignment(widget.cloudXAxis, widget.cloudYAxis),
      child: Image.asset(
        "assets/images/Clouds.png",
        height: MediaQuery.of(context).size.height * 0.2,
      ),
    );
  }
}
