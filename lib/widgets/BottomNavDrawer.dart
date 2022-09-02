import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BottomNavDrawer extends StatefulWidget {
  @override
  State<BottomNavDrawer> createState() => _BottomNavDrawerState();
}

class _BottomNavDrawerState extends State<BottomNavDrawer> {
  bool _expanded = true;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    setBottomBarIndex(index) {
      setState(() {
        currentIndex = index;
      });
    }

    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          height: size.height * 0.885,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1500),
            curve: Curves.fastLinearToSlowEaseIn,
            height: _expanded ? size.height * 0.112 : size.height * 0.7,
            decoration: const BoxDecoration(color: Colors.transparent),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: size.height * 0.112,
                  child: Stack(children: [
                    CustomPaint(
                      size: Size(size.width, 80),
                      painter: BNBCustomPainter(),
                    ),
                    Center(
                      heightFactor: 0.6,
                      child: FloatingActionButton(
                          elevation: 0.1,
                          onPressed: () {
                            setState(() {
                              _expanded = !_expanded;
                            });
                          },
                          child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(colors: [
                                    Color.fromARGB(255, 0, 80, 72),
                                    Color.fromARGB(255, 0, 80, 72),
                                  ])),
                              child: const Icon(Icons.arrow_upward))),
                    ),
                    Container(
                      width: size.width,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.home,
                                  color: currentIndex == 0
                                      ? const Color.fromARGB(255, 0, 80, 72)
                                      : Colors.grey.shade400,
                                ),
                                onPressed: () {
                                  setBottomBarIndex(0);
                                },
                                splashColor: Colors.white,
                              ),
                              Text("data"),
                            ],
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.restaurant_menu,
                                color: currentIndex == 1
                                    ? const Color.fromARGB(255, 0, 80, 72)
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setBottomBarIndex(1);
                              }),
                          Container(
                            width: size.width * 0.20,
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.bookmark,
                                color: currentIndex == 2
                                    ? const Color.fromARGB(255, 0, 80, 72)
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setBottomBarIndex(2);
                              }),
                          IconButton(
                              icon: Icon(
                                Icons.notifications,
                                color: currentIndex == 3
                                    ? const Color.fromARGB(255, 0, 80, 72)
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setBottomBarIndex(3);
                              }),
                        ],
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    width: size.width,
                    child: Column(
                      children: const [
                        FlutterLogo(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 20); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 20, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
