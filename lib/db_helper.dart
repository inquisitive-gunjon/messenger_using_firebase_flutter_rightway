
import 'package:cloud_firestore/cloud_firestore.dart';

class DbHelper{

  static const _collectionFriends = 'users';

  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllUsers() =>
      _db.collection(_collectionFriends )
          .snapshots();


}