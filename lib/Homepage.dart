import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
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
  bool Play = false;
  bool options = false;
  String standingmario = "assets/images/movement/standing mario.png";
  String runningmario = "assets/images/movement/mario running.png";
  String ruuning2mario = "assets/images/movement/mario start running.png";
  late String currentmario;
  int score = 0;
  int time = 0;
  late Timer timer;
  late Timer timer2;
  String CurrentIndex = "Play";
  double Volume = 40;
  late AssetsAudioPlayer _assetsAudioPlayer;

  @override
  void initState() {
    super.initState();
    currentmario = standingmario;
    _assetsAudioPlayer = AssetsAudioPlayer();
    _assetsAudioPlayer.open(
      Audio(
          "assets/music/SUPER MARIO BROS. Themesong ( No Copyright Music ).mp3"),
      volume: Volume,
    );
    _assetsAudioPlayer.play();

    timer2 = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        Play ? skyleftmovement() : null;
      },
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.stop();
    timer.cancel();
    _assetsAudioPlayer.dispose();
    timer2.cancel();
    super.dispose();
  }

  void skyleftmovement() async {
    if (cloud1XAxis < -1.6) {
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        cloud1XAxis = 1.6;
      });
    } else {
      setState(() {
        cloud1XAxis -= 0.02;
      });
    }
    if (cloud2XAxis < -1.6) {
      await Future.delayed(const Duration(seconds: 8));
      setState(() {
        cloud2XAxis = 1.6;
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
            IgnorePointer(
              ignoring: Play ? false : true,
              child: Column(
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
                            image: AssetImage("assets/images/Floor.jpg"),
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
            ),
            Play
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  Play = false;
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
                                            MediaQuery.of(context).size.width *
                                                0.002,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      )
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.home_filled,
                                    size: MediaQuery.of(context).size.width *
                                        0.05,
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
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.04),
                        child: Column(
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
                        ),
                      )
                    ],
                  )
                : options
                    ? Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  options = false;
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
                                            MediaQuery.of(context).size.width *
                                                0.002,
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                      )
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.home_filled,
                                    size: MediaQuery.of(context).size.width *
                                        0.05,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.03),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(3, 4),
                                                blurRadius: 0,
                                                spreadRadius:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.002,
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                              )
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01),
                                          child: Text(
                                            "Option Name",
                                            style: TextStyle(
                                                fontFamily: "Pixeboy",
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.035),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(3, 4),
                                                blurRadius: 0,
                                                spreadRadius:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.002,
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                              )
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01),
                                          child: Text(
                                            "Option Name",
                                            style: TextStyle(
                                                fontFamily: "Pixeboy",
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.035),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(3, 4),
                                                blurRadius: 0,
                                                spreadRadius:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.002,
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                              )
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01),
                                          child: Text(
                                            "Option Name",
                                            style: TextStyle(
                                                fontFamily: "Pixeboy",
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.035),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(3, 4),
                                                blurRadius: 0,
                                                spreadRadius:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.002,
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                              )
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.all(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01),
                                          child: Text(
                                            "Option Name",
                                            style: TextStyle(
                                                fontFamily: "Pixeboy",
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.035),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border:
                                                Border.all(color: Colors.black),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(3, 4),
                                                blurRadius: 0,
                                                spreadRadius:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.002,
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                              )
                                            ]),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Sfx Volume",
                                              style: TextStyle(
                                                  fontFamily: "Pixeboy",
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.02),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.all(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.01),
                                                child: Slider(
                                                  value: Volume,
                                                  onChanged: (value) {
                                                    Volume = value;
                                                  },
                                                  label: Volume.toString(),
                                                  max: 100,
                                                  activeColor: Colors.black,
                                                  min: 0,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                Play = true;
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                options = true;
                              });
                            },
                            child: Text(
                              "Options",
                              style: TextStyle(
                                  fontFamily: "Pixeboy",
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05),
                            ),
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
