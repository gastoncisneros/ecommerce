import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/home_page.dart';
import 'package:e_commerce/screens/landing_page.dart';
import 'package:e_commerce/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce/widgets/custom_button.dart';
import 'package:e_commerce/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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

  //Login user Account
  Future<String> _loginAccount() async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _userEmail,
        password: _userPassword
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
     _loginFormLoading = true; 
    });
 
    String _loginAccountFeedback = await _loginAccount();
    if(_loginAccountFeedback != null){
      _alertDialogBuilder(_loginAccountFeedback);
      
      setState(() {
      _loginFormLoading = false; 
      });
    } 
  }

  //Default form loading state
  bool _loginFormLoading = false;

  //Form input state variables
  String _userEmail = "";
  String _userPassword = "";
  
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
                  CustomInput(
                    hintText:"Email",
                    onChanged: (value){
                      _userEmail = value;
                    },
                    onSubmitted: (value){
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                    ),
                  CustomInput(
                    hintText:"Password",
                    onChanged: (value){
                      _userPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    onSubmitted: (value){
                      _submitForm();
                    },
                    isPasswordField: true,
                    ),
                  CustomBtn(
                    text: "Login",
                    onPressed:(){
                      _submitForm();
                    },
                    outlineBtn:false,
                    isLoading: _loginFormLoading,
                  )
                ],
              ),

              Padding(
                padding: EdgeInsets.only(
                  bottom: 16.0
                ),
                child: CustomBtn(
                text:"New Account", 
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => RegisterPage()
                  ));
                }, 
                 outlineBtn:true
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}