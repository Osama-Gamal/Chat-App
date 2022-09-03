import 'package:firebase_project/pages/ChatsPage.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../widgets/BottomNavDrawer.dart';

class HomeScreen extends StatefulWidget {
  static const String screenRoute = 'MainScreen';

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  double xoffSet = 0;
  double yoffSet = 0;
  double angle = 0;
  bool isOpen = false;
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    //const size = 200.0;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 80, 72),
      body: Center(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: 70,
                child: Row(
                  children: [
                    IconButton(
                      iconSize: 35,
                      icon: const Icon(
                        Icons.menu,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {},
                    ),
                    Flexible(flex: 1, child: Container()),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                          text: 'C',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                          children: [
                            TextSpan(
                              text: 'h',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 30),
                            ),
                            TextSpan(
                              text: 'at All',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                          ]),
                    ),
                    Flexible(flex: 1, child: Container()),
                    /*Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CircularPercentIndicator(
                        radius: 15.0,
                        lineWidth: 2.0,
                        percent: 0.7,
                        animation: true,
                        animateFromLastPercent: true,
                        center: const Icon(
                          Icons.person_pin,
                          size: 20.0,
                          color: Colors.blue,
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 216, 216, 216),
                        progressColor: Colors.blue,
                      ),
                    ),*/
                    IconButton(
                        onPressed: (() => {}),
                        icon: const Icon(
                          Icons.more,
                          color: Colors.white,
                          size: 20,
                        )),
                  ],
                ),
              ),
              Stack(
                children: [
                  Container(
                      height: size.height * 0.8854,
                      padding: const EdgeInsets.all(1.0),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 232, 244, 242),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18),
                            topRight: Radius.circular(18)),
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 12),
                        child: const ChatsPage(),
                      )),
                  BottomNavDrawer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
