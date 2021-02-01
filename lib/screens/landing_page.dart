import 'package:e_commerce/constants.dart';
import 'package:e_commerce/screens/login_page.dart';
import 'package:e_commerce/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LadingPage extends StatelessWidget{  

  final Future<FirebaseApp> _initialization = Firebase.initializeApp(); 

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child:Text("Error: ${snapshot.error}"),
              ),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          //StreamBuilder can check the login state live
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamsnapshot){
              if(streamsnapshot.hasError){
                return Scaffold(
                  body: Center(
                    child:Text("Error: ${streamsnapshot.error}"),
                    ),
                );
              }

              //Connection State active = Do the login check inside the 
              //if statement
              if(streamsnapshot.connectionState == ConnectionState.active){
                //Get the user
                User _user = streamsnapshot.data;

                //If the user is null return Login Page
                if(_user == null){
                  return LoginPage();
                }else{
                  return HomePage();
                }
              }

              return Scaffold(
                body: Center(
                  child: Text("Checking the Auth State...",
                    style: Constants.regularHeading,
                  ),
                ),
              );
            },
          );
        }

        return Scaffold(
          body: Center(
            child: Text("Initializing App...",
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}