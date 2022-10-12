import 'package:flutter/material.dart';

class GiftBox extends StatefulWidget {
  final double giftboxXAxis;

  final double giftboxYAxis;

  final double height;

  final double width;

  const GiftBox(
      {super.key,
      required this.giftboxXAxis,
      required this.giftboxYAxis,
      required this.height,
      required this.width});

  @override
  State<GiftBox> createState() => _GiftBoxState();
}

class _GiftBoxState extends State<GiftBox> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      // height: MediaQuery.of(context).size.height * 0.1,
      // width: MediaQuery.of(context).size.width * 0.05,
      alignment: Alignment(widget.giftboxXAxis, widget.giftboxYAxis),
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Image.asset(
          "assets/images/gif/giftbox.gif",
        ),
      ),
    );
  }
}
