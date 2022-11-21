import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Pages/Box.dart';
import 'package:flutter_application_1/Pages/Mario.dart';
import 'package:flutter_application_1/Pages/clouds.dart';
import 'package:flutter_application_1/Pages/giftBox.dart';
import 'package:flutter_application_1/Pages/mushroom.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double xMarioAxis = -0.8;
  double yMarioAxis = 1.0;
  double cloud1XAxis = -0.7;
  double cloud1YAxis = -0.8;
  double cloud2XAxis = 0.7;
  double cloud2YAxis = -0.8;
  bool leftmovementblocked = false;
  bool rightmovementblocked = false;
  bool jumpmovementblocked = false;
  Timer? leftwalktimer;
  Timer? rightwalktimer;
  double boxXAxis = 0;
  double boxYAxis = 1.08;
  double giftboxXAxis = 0.3;
  double giftboxYAxis = -0.1;
  late double giftboxheight;
  late double giftboxWidth;
  late double boxheight;
  late double boxWidth;
  late double mushroomheight;
  late double mushroomWidth;
  double mushroomXAxis = -0.3;
  double mushroomYAxis = 1.1;
  bool onmushroom = false;

  bool isplaying = false;
  bool options = false;
  bool clouds = true;
  bool birds = true;
  bool music = true;
  String standingmario = "assets/images/movement/standing mario.png";
  String runningmario = "assets/images/movement/mario running.png";
  String ruuning2mario = "assets/images/movement/mario start running.png";
  late String currentmario;
  int score = 0;
  int time = 0;
  Timer? timer;
  Timer? timer2;
  String currentIndex = "Play";
  double volume = 40;
  late AssetsAudioPlayer _assetsAudioPlayer;
  bool changinglocation1 = false;
  bool changinglocation2 = false;

  @override
  void initState() {
    super.initState();
    currentmario = standingmario;
    _assetsAudioPlayer = AssetsAudioPlayer();
    _assetsAudioPlayer.open(
      Audio(
          "assets/music/SUPER MARIO BROS. Themesong ( No Copyright Music ).mp3"),
      volume: volume,
    );
    _assetsAudioPlayer.play();
    _assetsAudioPlayer.setLoopMode(LoopMode.single);
  }

  @override
  void dispose() {
    _assetsAudioPlayer.stop();
    timer?.cancel();
    _assetsAudioPlayer.dispose();
    timer2?.cancel();
    super.dispose();
  }

  void skyleftmovement() async {
    if (cloud1XAxis < -1.8) {
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        changinglocation1 = true;

        cloud1XAxis = 1.8;
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        changinglocation1 = false;
      });
    } else {
      setState(() {
        cloud1XAxis -= 0.02;
      });
    }
  }

  void skyleftmovement2() async {
    if (cloud2XAxis < -1.8) {
      await Future.delayed(const Duration(seconds: 8));
      setState(() {
        changinglocation2 = true;

        cloud2XAxis = 1.8;
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        changinglocation2 = false;
      });
    } else {
      setState(() {
        cloud2XAxis -= 0.02;
      });
    }
  }

  void startmovement() async {
    setState(() {
      yMarioAxis = 0.7;
      currentmario = runningmario;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      yMarioAxis = 1.0;
      currentmario = standingmario;
    });
    startimeAndcloudmovement();
  }

  void endplaymoment() {
    timer?.cancel();
    timer2?.cancel();
  }

  void startimeAndcloudmovement() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        time += 1;
        skyleftmovement();
        skyleftmovement2();
      });
      return;
    });
  }

  void walkleft() async {
    {
      setState(() {
        currentmario = runningmario;
        if (xMarioAxis < -1) {
        } else {
          xMarioAxis -= 0.02;
          currentmario = ruuning2mario;
          score -= -1;
        }
      });
    }

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      currentmario = standingmario;
    });
  }

  void walkright() async {
    setState(() {
      currentmario = runningmario;
      if (xMarioAxis > 0.7) {
      } else {
        xMarioAxis += 0.03;
        currentmario = ruuning2mario;
        score += 2;
      }
    });

    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      currentmario = standingmario;
    });
  }

  void jump() async {
    if (yMarioAxis > -1) {
      setState(() {
        yMarioAxis -= 0.5;
        currentmario = runningmario;
      });

      await Future.delayed(const Duration(milliseconds: 600));
      setState(() {
        yMarioAxis += 0.5;
        currentmario = standingmario;
      });
    }
  }

  collisionWithMushroom() {
    if (yMarioAxis >= mushroomYAxis - 0.1 &&
        yMarioAxis <= mushroomYAxis + 0.1) {
      if (xMarioAxis >= mushroomXAxis - 0.1 &&
          xMarioAxis <= mushroomXAxis + 0.1) {
        setState(() {
          onmushroom = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    giftboxheight = MediaQuery.of(context).size.height * 0.15;
    giftboxWidth = MediaQuery.of(context).size.width * 0.07;
    boxheight = MediaQuery.of(context).size.height * 0.125;
    boxWidth = MediaQuery.of(context).size.width * 0.05;
    mushroomheight = MediaQuery.of(context).size.height * 0.125;
    mushroomWidth = MediaQuery.of(context).size.width * 0.05;

    return Material(
      child: Stack(
        children: [
          IgnorePointer(
            ignoring: isplaying ? false : true,
            child: Column(
              children: [
                Container(
                  color: Colors.blue,
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      clouds
                          ? Clouds(
                              cloudXAxis: cloud1XAxis,
                              cloudYAxis: cloud1YAxis,
                              changinglocation: changinglocation1,
                            )
                          : Container(),
                      clouds
                          ? Clouds(
                              cloudXAxis: cloud2XAxis,
                              cloudYAxis: cloud2YAxis,
                              changinglocation: changinglocation2,
                            )
                          : Container(),
                      onmushroom
                          ? Container()
                          : Mushroom(
                              xAxis: mushroomXAxis,
                              yAxis: mushroomYAxis,
                              height: mushroomheight,
                              width: mushroomWidth),
                      Box(
                        boxXAxis: boxXAxis,
                        boxYAxis: boxYAxis,
                        height: boxheight,
                        width: boxWidth,
                      ),
                      GiftBox(
                        giftboxXAxis: giftboxXAxis,
                        giftboxYAxis: giftboxYAxis,
                        height: giftboxheight,
                        width: giftboxWidth,
                      ),
                      Mario(
                        marioXAxis: xMarioAxis,
                        marioYAxis: yMarioAxis,
                        currentmario: currentmario,
                        ismariosmall: onmushroom,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: MediaQuery.of(context).size.height * 0.25,
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
                          GestureDetector(
                            onTapDown: (details) {
                              leftwalktimer = Timer.periodic(
                                const Duration(milliseconds: 100),
                                (timer) {
                                  collisionWithMushroom();
                                  if (yMarioAxis >= mushroomYAxis - 0.1 &&
                                      yMarioAxis <= mushroomYAxis + 0.1) {
                                    if (xMarioAxis >= boxXAxis - 0.05 &&
                                        xMarioAxis <= boxXAxis + 0.11) {
                                      setState(() {
                                        leftmovementblocked = true;
                                      });
                                    } else {
                                      setState(() {
                                        leftmovementblocked = false;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      leftmovementblocked = false;
                                    });
                                  }

                                  leftmovementblocked ? null : walkleft();
                                },
                              );
                            },
                            onTapUp: (details) {
                              leftwalktimer?.cancel();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.012),
                                child: const Icon(Icons.arrow_back,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                                onPressed: () {
                                  if (giftboxXAxis + giftboxWidth / 2 <
                                          xMarioAxis &&
                                      giftboxXAxis - giftboxWidth / 2 >
                                          xMarioAxis) {
                                    if (giftboxYAxis + giftboxheight / 2 <
                                            yMarioAxis &&
                                        giftboxYAxis - giftboxheight / 2 >
                                            yMarioAxis) {
                                      setState(() {
                                        jumpmovementblocked = true;
                                      });
                                    }
                                    {
                                      setState(() {
                                        jumpmovementblocked = false;
                                      });
                                    }
                                  }
                                  {}

                                  jumpmovementblocked ? null : jump();
                                },
                                color: Colors.white,
                                icon: const Icon(
                                  Icons.arrow_upward,
                                )),
                          ),
                          GestureDetector(
                            onTapDown: (details) {
                              rightwalktimer = Timer.periodic(
                                const Duration(milliseconds: 100),
                                (timer) {
                                  collisionWithMushroom();
                                  if (yMarioAxis >= mushroomYAxis - 0.1 &&
                                      yMarioAxis <= mushroomYAxis + 0.1) {
                                    if (xMarioAxis >= boxXAxis - 0.1 &&
                                        xMarioAxis <= boxXAxis + 0.11) {
                                      setState(() {
                                        rightmovementblocked = true;
                                      });
                                    } else {
                                      setState(() {
                                        rightmovementblocked = false;
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      rightmovementblocked = false;
                                    });
                                  }
                                  rightmovementblocked ? null : walkright();
                                },
                              );
                            },
                            onTapUp: (details) {
                              rightwalktimer?.cancel();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          isplaying
              ? play()
              : options
                  ? option()
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
                              isplaying = true;
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
    );
  }

  Widget play() {
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
                    isplaying = false;
                    endplaymoment();
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
              score.toString(),
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
                time.toString(),
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

  Widget option() {
    return Stack(
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
                      spreadRadius: MediaQuery.of(context).size.width * 0.002,
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
        Center(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          clouds = !clouds;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(3, 4),
                                blurRadius: 0,
                                spreadRadius:
                                    MediaQuery.of(context).size.width * 0.002,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              )
                            ]),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.01),
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                "Clouds : ${clouds ? "on" : "off"}",
                                style: TextStyle(
                                    fontFamily: "Pixeboy",
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          birds = !birds;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(3, 4),
                                blurRadius: 0,
                                spreadRadius:
                                    MediaQuery.of(context).size.width * 0.002,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              )
                            ]),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.01),
                            child: Text(
                              "Birds : ${birds ? "on" : "off"} ",
                              style: TextStyle(
                                  fontFamily: "Pixeboy",
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.035),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          music = !music;
                          music
                              ? _assetsAudioPlayer.play()
                              : _assetsAudioPlayer.pause();
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(3, 4),
                                blurRadius: 0,
                                spreadRadius:
                                    MediaQuery.of(context).size.width * 0.002,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              )
                            ]),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.01),
                            child: Text(
                              "Music : ${music ? "on" : "off"}",
                              style: TextStyle(
                                  fontFamily: "Pixeboy",
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.035),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Phoenix.rebirth(context);
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.14,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(3, 4),
                                blurRadius: 0,
                                spreadRadius:
                                    MediaQuery.of(context).size.width * 0.002,
                                color: const Color.fromARGB(255, 0, 0, 0),
                              )
                            ]),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.01),
                            child: Text(
                              "Reset",
                              style: TextStyle(
                                  fontFamily: "Pixeboy",
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.035),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(3, 4),
                              blurRadius: 0,
                              spreadRadius:
                                  MediaQuery.of(context).size.width * 0.002,
                              color: const Color.fromARGB(255, 0, 0, 0),
                            )
                          ]),
                      child: Column(
                        children: [
                          Text(
                            "Sfx Volume",
                            style: TextStyle(
                                fontFamily: "Pixeboy",
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.02),
                          ),
                          Padding(
                              padding: EdgeInsets.all(
                                  MediaQuery.of(context).size.width * 0.01),
                              child: Slider(
                                value: volume,
                                onChanged: (value) {
                                  setState(() {
                                    volume = value;
                                    _assetsAudioPlayer.setVolume(volume / 100);
                                  });
                                },
                                label: volume.toString(),
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
    );
  }
}
