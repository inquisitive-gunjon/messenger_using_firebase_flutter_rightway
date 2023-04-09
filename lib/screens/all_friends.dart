
import 'package:flutter/material.dart';

class AllFriends extends StatefulWidget {
  const AllFriends({Key? key}) : super(key: key);

  @override
  State<AllFriends> createState() => _AllFriendsState();
}

class _AllFriendsState extends State<AllFriends> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('All Friends'),),

    );
  }
}
