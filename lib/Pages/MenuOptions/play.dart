import 'package:flutter/material.dart';

class Play extends StatefulWidget {
  bool play;
  int score;
  int time;
  Function endplaymoment;

  Play(
      {super.key,
      required this.play,
      required this.score,
      required this.time,
      required this.endplaymoment()});

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    widget.play = false;
                    widget.endplaymoment();
                  });
                },
                child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(3, 4),
                          blurRadius: 0,
                          spreadRadius:
                              MediaQuery.of(context).size.width * 0.002,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.home_filled,
                      size: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Mario",
              style: TextStyle(
                  fontFamily: "Pixeboy",
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            Text(
              widget.score.toString(),
              style: TextStyle(
                  fontFamily: "Pixeboy",
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "World",
              style: TextStyle(
                  fontFamily: "Pixeboy",
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
            Text(
              "1-2",
              style: TextStyle(
                  fontFamily: "Pixeboy",
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Image.asset("assets/images/coin.png", scale: 60),
                Text(
                  " Coins",
                  style: TextStyle(
                      fontFamily: "Pixeboy",
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.04),
                ),
              ],
            ),
            Text(
              "0",
              style: TextStyle(
                  fontFamily: "Pixeboy",
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.04),
            ),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Time",
                style: TextStyle(
                    fontFamily: "Pixeboy",
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
              Text(
                widget.time.toString(),
                style: TextStyle(
                    fontFamily: "Pixeboy",
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              ),
            ],
          ),
        )
      ],
    );
  }
}
