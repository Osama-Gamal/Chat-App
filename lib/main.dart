import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/screens/MainScreen.dart';
import 'package:firebase_project/screens/chatScreen.dart';
import 'package:firebase_project/screens/introScreen.dart';
import 'package:firebase_project/screens/loginScreen.dart';
import 'package:firebase_project/screens/resgisterScreen.dart';
import 'package:firebase_project/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //home: const ChatScreen(),
      initialRoute: _auth.currentUser != null
          ? ChatScreen.screenRoute
          : HomeScreen.screenRoute,
      routes: {
        IntroScreen.screenRoute: (context) => const IntroScreen(),
        WelcomeScreen.screenRoute: (context) => const WelcomeScreen(),
        LoginScreen.screenRoute: (context) => const LoginScreen(),
        RegisterScreen.screenRoute: (context) => const RegisterScreen(),
        HomeScreen.screenRoute: (context) => HomeScreen(),
        ChatScreen.screenRoute: (context) => const ChatScreen(),
      },
    );
  }
}
