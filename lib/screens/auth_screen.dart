
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../main.dart';
import '../reusable_widget/reusable_appbtn_style.dart';
import '../reusable_widget/reusable_appinput_decoration.dart';



class AuthScreen extends StatefulWidget {

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  //sign in with google with firebase.........

  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signInFunction()async{
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if(googleUser == null){
      return;
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // login korar por data golo firestore a chole jabe...
    DocumentSnapshot userExist = await firestore.collection('users').doc(userCredential.user!.uid).get();

    if(userExist.exists){
      print("User Already Exists in Database");
    }
    //jodi notun user thake ai document golo niye firebase store a chole jabe
    else{
       await firestore.collection('users').doc(userCredential.user!.uid).set({
      'email':userCredential.user!.email,
      'name':userCredential.user!.displayName,
      'image':userCredential.user!.photoURL,
      'uid':userCredential.user!.uid,
      'date':DateTime.now(),
    });
    }

   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MyApp()), (route) => false);


  }


  /// this is for email and password sign in and sign up

  final _formkey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String errMsg = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Flutter Chat App",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

              SizedBox(height: 30,),

              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'This filed must not be empty';
                  }
                  return null;
                },
                decoration:  reusableAppInputDecoration('Email'),
                onSaved: (value){
                  _email = value;
                },


              ),
              const SizedBox(height: 10,),
              TextFormField(
                obscureText: true,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'This filed must not be empty';
                  }
                  return null;
                },
                decoration: reusableAppInputDecoration('password'),

                onSaved: (value){
                  _password = value;
                },


              ),

              const SizedBox(height: 30,),

              ElevatedButton(onPressed: ()async{

              },style: appButtonStyle(), child: const Text('Login')

              ),

              ElevatedButton(onPressed: ()async{
                  await signInFunction();
              },style: appButtonStyle(),
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network('https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',height: 36,),
                  const SizedBox(width: 10,),
                  const Text("Sign in With Google",style: TextStyle(fontSize: 20),)
                ],
              ),
              ),
            ],
          ),
        ),
      ),

    );
  }




}