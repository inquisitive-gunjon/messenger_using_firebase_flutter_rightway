




/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_chatapp/models/user_model.dart';
import 'package:simple_chatapp/reusable_widget/reusable_appinput_decoration.dart';

import '../auth/auth_services.dart';
import '../reusable_widget/reusable_appbtn_style.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

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
      appBar: AppBar(title: Text('Registration Screen'),) ,
      body: Form(
        key: _formkey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.all(10),
            shrinkWrap: true,
            children: [

              //email
              TextFormField(
                controller: _emailContoller,
                keyboardType: TextInputType.emailAddress,
                decoration: reusableAppInputDecoration('Email Address'),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'This filed must not be empty';
                  }
                  return null;
                },


              ),
              const SizedBox(height: 10,),
              //name
              TextFormField(
                controller: _nameController,
                decoration: reusableAppInputDecoration('name'),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'This filed must not be empty';
                  }
                  return null;
                },


              ),

              const SizedBox(height: 10,),

              //image

              TextFormField(

                controller: _imageController,
                decoration: reusableAppInputDecoration('Image link'),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'This filed must not be empty';
                  }
                  return null;
                },


              ),
              const SizedBox(height: 10,),
              //password
              TextFormField(
                obscureText: _obscureText,
                controller: _passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText; //true hole visibilityt off thakbe and click korle on hobe toggle hoye jabe
                      });
                    },
                  ),
                  hintText: 'Password',
                  border: const OutlineInputBorder(),

                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'This filed must not be empty';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20,),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: appButtonStyle(),
                    onPressed:() async{
                        _registrationUser();
                    },
                    child: Text('Sign Up',style: TextStyle(fontSize: 20),)),
              ),




            ],


          ),
        ),

      ),

    );





  }


}*/
