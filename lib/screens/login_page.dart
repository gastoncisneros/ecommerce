import 'package:e_commerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Container(
                padding: EdgeInsets.only(
                  top: 24.0
                ),
                child: Text("Welcome User, \n Login to your Account",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
                ),
              ),

              Column(
                children: <Widget>[
                  CustomInput(),
                  CustomInput(),
                  CustomBtn(
                    "Login",
                    (){
                      print("Pressed button login");
                    },
                    true
                  )
                ],
              ),

              CustomBtn(
                "New Account", 
                (){
                  print("Clicked the new account button");
                }, 
                 true
              )
            ],
          ),
        ),
      )
    );
  }
}