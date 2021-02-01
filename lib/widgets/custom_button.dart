import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
final String text;
final Function onPressed;
final bool outlineBtn;

CustomBtn(this.text, this.onPressed, this.outlineBtn);

  @override
  Widget build(BuildContext context) {

  bool _outlineBtn = outlineBtn ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0
          ),
          borderRadius: BorderRadius.circular(12.0)
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24.0
        ),
        child: Text(
          text ?? "Create New Accont",
          style: TextStyle(
          fontSize: 16.0,
          color: _outlineBtn ? Colors.black : Colors.white,
          fontWeight: FontWeight.w600
          ),
        ),
      )
    );
  } 
}