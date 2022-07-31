import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_app/ui/theme.dart';

class MyButton extends StatelessWidget {
  final String buttonText;
  final Function()? onTap;
  const MyButton({Key? key, required this.buttonText, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: buttonColor),
        child: Center(
          child: Text(
            buttonText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
