import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double XMarioAxis = 0.0;
  double YMarioAxis = 1.0;
  double cloud1XAxis = -0.7;
  double cloud1YAxis = -0.8;
  double cloud2XAxis = 0.7;
  double cloud2YAxis = -0.8;
  bool gamestart = false;
  String standingmario = "assets/images/movement/standing mario.png";
  String runningmario = "assets/images/movement/mario running.png";
  String ruuning2mario = "assets/images/movement/mario start running.png";
  late String currentmario;
  int score = 0;
  int time = 0;
  late Timer timer;
  String CurrentIndex = "Play";

  @override
  void initState() {
    super.initState();
    currentmario = standingmario;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void skyleftmovement() async {
    if (cloud1XAxis < -1.1) {
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        cloud1XAxis = 1.1;
      });
    } else {
      setState(() {
        cloud1XAxis -= 0.02;
      });
    }
    if (cloud2XAxis < -1.1) {
      await Future.delayed(const Duration(seconds: 8));
      setState(() {
        cloud2XAxis = 1.1;
      });
    } else {
      setState(() {
        cloud2XAxis -= 0.02;
      });
    }
  }

  void skyrightmovement() async {
    if (cloud1XAxis > 1.1) {
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        cloud1XAxis = -1.1;
      });
    } else {
      setState(() {
        cloud1XAxis += 0.02;
      });
    }
    if (cloud2XAxis > 1.1) {
      await Future.delayed(const Duration(seconds: 8));
      setState(() {
        cloud2XAxis = -1.1;
      });
    } else {
      setState(() {
        cloud2XAxis += 0.02;
      });
    }
  }

  void startmovement() async {
    setState(() {
      YMarioAxis = 0.7;
      currentmario = runningmario;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      YMarioAxis = 1.0;
      currentmario = standingmario;
    });
    startime();
  }

  void startime() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        time += 1;
      });
      return;
    });
  }

  void walkleft() async {
    setState(() {
      currentmario = runningmario;
      XMarioAxis -= 0.02;
      currentmario = ruuning2mario;
      score -= -1;
    });

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      currentmario = standingmario;
    });
  }

  void walkright() async {
    setState(() {
      currentmario = runningmario;

      XMarioAxis += 0.03;
      currentmario = ruuning2mario;
      score += 2;
    });

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      currentmario = standingmario;
    });
  }

  void jump() async {
    setState(() {
      YMarioAxis -= 0.5;
      currentmario = runningmario;
    });

    await Future.delayed(const Duration(milliseconds: 600));
    setState(() {
      YMarioAxis += 0.5;
      currentmario = standingmario;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: Colors.blue,
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        alignment: Alignment(cloud1XAxis, cloud1YAxis),
                        child: Image.asset(
                          "assets/images/Clouds.png",
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        alignment: Alignment(cloud2XAxis, cloud2YAxis),
                        child: Image.asset(
                          "assets/images/Clouds.png",
                          height: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        alignment: Alignment(XMarioAxis, YMarioAxis),
                        child: Image.asset(
                          currentmario,
                          height: MediaQuery.of(context).size.height * 0.12,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2380,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: MediaQuery.of(context).size.height * 0.2380,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/floor.jpg"),
                        )),
                        alignment: const Alignment(0, 0),
                      ),
                      Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                onPressed: () {
                                  walkleft();
                                  skyrightmovement();
                                },
                                color: Colors.white,
                                icon: const Icon(
                                  Icons.arrow_back,
                                )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                onPressed: () {
                                  jump();
                                },
                                color: Colors.white,
                                icon: const Icon(
                                  Icons.arrow_upward,
                                )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                onPressed: () {
                                  walkright();
                                  skyleftmovement();
                                },
                                color: Colors.white,
                                icon: const Icon(
                                  Icons.arrow_forward,
                                )),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
            gamestart
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Mario",
                            style: TextStyle(
                                fontFamily: "Pixeboy",
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          Text(
                            score.toString(),
                            style: TextStyle(
                                fontFamily: "Pixeboy",
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
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
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          Text(
                            "1-2",
                            style: TextStyle(
                                fontFamily: "Pixeboy",
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
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
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.04),
                              ),
                            ],
                          ),
                          Text(
                            "0",
                            style: TextStyle(
                                fontFamily: "Pixeboy",
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Time",
                            style: TextStyle(
                                fontFamily: "Pixeboy",
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                          Text(
                            time.toString(),
                            style: TextStyle(
                                fontFamily: "Pixeboy",
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04),
                          ),
                        ],
                      )
                    ],
                  )
                : Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo/logo.png",
                        scale: MediaQuery.of(context).size.width * 0.01,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Future.delayed(
                              const Duration(microseconds: 600));
                          setState(() {
                            gamestart = true;
                            startmovement();
                          });
                        },
                        child: Text(
                          "Play",
                          style: TextStyle(
                              fontFamily: "Pixeboy",
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05),
                        ),
                      ),
                      Text(
                        "Options",
                        style: TextStyle(
                            fontFamily: "Pixeboy",
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.05),
                      ),
                      GestureDetector(
                        onTap: () {
                          SystemNavigator.pop();
                        },
                        child: Text(
                          "Exit",
                          style: TextStyle(
                              fontFamily: "Pixeboy",
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05),
                        ),
                      ),
                    ],
                  )),
          ],
        ),
      ),
    );
  }
}
