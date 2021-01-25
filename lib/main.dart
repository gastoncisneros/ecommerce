import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LadingPage()
    );
  }
}

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
          return Scaffold(
            body: Container(
              child: Center(
                child: Text("Firebase App"),
              ),
            ),
          );
        }

        return Scaffold(
          body: Container(
            child: Text("Initializing App..."),
          ),
        );
      },
    );
  }
}