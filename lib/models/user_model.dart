

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String email;
  String? name;
  String? image;
  Timestamp? date;
  String uid;

  UserModel({
    required this.email,
    this.name,
    this.image,
    this.date,
    required this.uid
  });


  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'uid' : uid,
      'name' : name,
      'email' : email,
      'image' : image,
      'date' : date,
    };
    return map;
  }

  factory UserModel.fromJson(DocumentSnapshot snapshot){
    return UserModel(
      email: snapshot['email'],
       name: snapshot['name'],
        image: snapshot['image'],
         date: snapshot['date'],
          uid: snapshot['uid'],
    );
  }


}