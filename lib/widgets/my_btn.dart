import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class welcomeBtn extends StatelessWidget {
  welcomeBtn(
      {required this.btnColor, required this.btnTxt, required this.onPressed});

  final Color btnColor;
  final String btnTxt;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: btnColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 150,
          height: 42,
          child: Text(
            btnTxt,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
