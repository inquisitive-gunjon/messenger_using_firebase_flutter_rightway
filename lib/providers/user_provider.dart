

import 'package:flutter/cupertino.dart';

import '../dbhelper/db_helper.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier{

  Future<void> addUser(UserModel userModel) {
    return DBHelper.addNewUser(userModel);

  }





}