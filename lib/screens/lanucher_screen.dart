

import 'package:flutter/material.dart';
import 'package:simple_chatapp/auth/auth_services.dart';
import 'package:simple_chatapp/screens/registration_screen.dart';


class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher';
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      if(AuthServices.currentUser == null ) {
        //Navigator.pushReplacementNamed(context, LoginPage.routeName)
      }else {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}