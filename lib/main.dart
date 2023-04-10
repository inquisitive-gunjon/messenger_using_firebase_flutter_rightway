

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_chatapp/screens/auth_screen.dart';
import 'package:simple_chatapp/screens/home_screen.dart';

import 'models/user_model.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.


  //here we take decision where will app go ,auth screen or home screen
  Future<Widget> userSignedIn()async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
      DocumentSnapshot userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      UserModel userModel = UserModel.fromJson(userData);
      return HomeScreen(userModel);
    }else{
      return  AuthScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:
        FutureBuilder(
            future: userSignedIn(),
            builder: (context,AsyncSnapshot<Widget> snapshot){
              if(snapshot.hasData){
                return snapshot.data!;
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            })
    );
  }
}