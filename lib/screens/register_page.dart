import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/custom_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  //Build an alert dialog to display some errors
  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          title: Text("Error"),
          content: Container(
            child: Text(error),
          ),
          actions: [
            FlatButton(
              child: Text("Close Dialog"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  //Create new user Account
  Future<String> _createAccount() async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _registerEmail,
        password: _registerPassword
      );

      return null;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async{

    setState(() {
     _registerFormLoading = true; 
    });
 
    String _crateAccountFeedback = await _createAccount();
    if(_crateAccountFeedback != null){
      _alertDialogBuilder(_crateAccountFeedback);
      
      setState(() {
      _registerFormLoading = false; 
      });
    } else{
      //The string was null so user is logued in.
      Navigator.pop(context);
    }
    
  }

  //Default form loading state
  bool _registerFormLoading = false;

  //Form input state variables
  String _registerEmail = "";
  String _registerPassword = "";
  
  //Focus node for input field
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
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
                child: Text("Create a new Account",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
                ),
              ),

              Column(
                children: <Widget>[
                  CustomInput(
                    hintText: "Email",
                    onChanged: (value){
                      _registerEmail = value;
                    },
                    onSubmitted: (value){
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                    ),
                  CustomInput(
                    hintText:"Password",
                    onChanged: (value){
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmitted: (value){
                      _submitForm();
                    },
                    ),
                  CustomBtn(
                    text: "Create Account",
                    onPressed: (){
                      _submitForm();
                    },
                    outlineBtn: false,
                    isLoading: _registerFormLoading,
                  )
                ],
              ),

              Padding(
                padding: EdgeInsets.only(
                  bottom: 16.0
                ),
                child: CustomBtn(
                text:"Back to Login", 
                onPressed:(){
                  Navigator.pop(context);
                }, 
                 outlineBtn: true,
                 isLoading: false
                ),
              )
            ],
          ),
        ),
      )
     ),
    );
  }
}
