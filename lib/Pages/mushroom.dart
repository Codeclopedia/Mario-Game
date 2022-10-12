import 'package:flutter/cupertino.dart';

class Mushroom extends StatelessWidget {
  final double xAxis;
  final double yAxis;
  final double height;

  final double width;
  const Mushroom(
      {super.key,
      required this.xAxis,
      required this.yAxis,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      alignment: Alignment(xAxis, yAxis),
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset("assets/images/mario-mushroom.png"),
      ),
    );
  }
}
