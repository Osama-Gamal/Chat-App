import 'package:firebase_project/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  static const String screenRoute = 'IntroScreen';

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: "A reader live thousands of lives",
          body: "The man who not read lives only one life",
          decoration: const PageDecoration(
              imagePadding: EdgeInsets.only(top: 10),
              bodyAlignment: Alignment.center),
          image: Image.asset(
            'assets/images/chat.png',
            width: 250,
          ),
        ),
        PageViewModel(
          title: "A reader live thousands of lives",
          body: "The man who not read lives only one life",
          decoration: const PageDecoration(
              imagePadding: EdgeInsets.only(top: 10),
              bodyAlignment: Alignment.center),
          image: Image.asset(
            'assets/images/chat.png',
            width: 250,
          ),
        ),
        PageViewModel(
          title: "A reader live thousands of lives",
          body: "The man who not read lives only one life",
          decoration: const PageDecoration(
              imagePadding: EdgeInsets.only(top: 10),
              bodyAlignment: Alignment.center),
          image: Image.asset(
            'assets/images/chat.png',
            width: 250,
          ),
        ),
        PageViewModel(
          title: "A reader live thousands of lives",
          body: "The man who not read lives only one life",
          decoration: const PageDecoration(
              imagePadding: EdgeInsets.only(top: 10),
              bodyAlignment: Alignment.center),
          image: Image.asset(
            'assets/images/chat.png',
            width: 250,
          ),
        ),
      ],
      dotsDecorator: DotsDecorator(
        activeColor: Colors.green,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      skip: const Text("Skip"),
      showSkipButton: true,
      next: const Text("Next"),
      done: const Text(
        "Done",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onDone: () {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const WelcomeScreen(),
          ),
        );
      },
    );
  }
}
