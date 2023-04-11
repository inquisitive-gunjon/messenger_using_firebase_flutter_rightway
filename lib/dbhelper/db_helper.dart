
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class DBHelper {
  static const _collectionUser = 'Users';
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addNewUser(UserModel userModel) {
    return _db.collection(_collectionUser).doc(userModel.uid).set(
        userModel.toMap());
  }


}