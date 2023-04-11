
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:simple_chatapp/screens/chat_screen.dart';
import 'package:simple_chatapp/screens/registration_screen.dart';

import '../auth/auth_services.dart';
import '../main.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
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
  final _emailContoller = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  bool _obscureText = true;
  String _errMsg = '';
  bool isLogin = true;
  Timestamp? Datetime;

  void dispose() {
    _emailContoller.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _imageController.dispose();
    super.dispose();
  }


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
                controller: _emailContoller,
                keyboardType: TextInputType.emailAddress,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'This filed must not be empty';
                  }
                  return null;
                },
                decoration:  reusableAppInputDecoration('Email'),



              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'This filed must not be empty';
                  }
                  return null;
                },
                decoration: reusableAppInputDecoration('password'),




              ),

              const SizedBox(height: 30,),

              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: appButtonStyle(),
                    onPressed:(){
                      isLogin = true;
                      _loginUser();

                    },
                    child: Text('Login',style: TextStyle(fontSize: 20),)),
              ),

              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('New User ?'),
                  TextButton(
                      onPressed: (){
                         isLogin = false;
                        // _loginUser();

                      },
                      child: Text('Register',style: TextStyle(fontSize: 18),)),
                ],
              ),
              Text(''),

              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: appButtonStyle(),
                    onPressed:() async{
                      await signInFunction();

                    },
                    child: Text('Sign in with google',style: TextStyle(fontSize: 20),)),
              ),

            ],
          ),
        ),
      ),

    );
  }

  void _loginUser() async {

    if(_formkey.currentState!.validate()){
      //er dara bujasse jodi empty na thake,user kiso type krse kina
      try{
        User? user;
        //er dara bujasse user login button a press krse
        if(isLogin){
          //login krok or regester korok user er modde kiso ekta akhon dokbe
          user = await  AuthServices.loginUser(_emailContoller.text, _passwordController.text);
        }
        else{
          user = await AuthServices.registerUser(_emailContoller.text, _passwordController.text);

        }
        // user er modde akhon kiso na kiso dokse, tobe jawar age user er information golo niye database a save kore rakhbo
        if(user != null) {
          //todo create user and insert to db
          if(!isLogin) {
            final userModel = UserModel(
                email: user.email!,
                 uid: user.uid,
            );
            Provider.of<UserProvider>(context, listen: false)
                .addUser(userModel).then((value) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp()));
            });
          }
        }

      } on FirebaseAuthException catch (error) {
        setState(() {
          _errMsg = error.message!;
        });
      }

    }


  }


}