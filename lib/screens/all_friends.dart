
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'chat_screen.dart';


class AllFriendScreen extends StatefulWidget {
  UserModel user;
  AllFriendScreen(this.user);

  @override
  _AllFriendScreenState createState() => _AllFriendScreenState();
}

class _AllFriendScreenState extends State<AllFriendScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> allFriendsSearch =[];
  bool isLoading = false;

  void onSearch()async{
    setState(() {
      allFriendsSearch = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection('users').get().then((value){
      if(value.docs.length < 1){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No User Found")));
        setState(() {
          isLoading = false;
        });
        return;
      }
      value.docs.forEach((user) {
        if(user.data()['email'] != widget.user.email){
          allFriendsSearch.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Friends Screen"),
        actions: [
          TextButton(onPressed: onSearch, child: Text('all Frinds',style: TextStyle(color: Colors.black),))
        ],
      ),
      body:  ListView.builder(
          itemCount: allFriendsSearch.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
            return ListTile(
              leading: CircleAvatar(
                child: Image.network(allFriendsSearch[index]['image']),
              ),
              title: Text(allFriendsSearch[index]['name']),
              subtitle: Text(allFriendsSearch[index]['email']),
              trailing: IconButton(onPressed: (){
                setState(() {
                  searchController.text = "";
                });
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(
                    currentUser: widget.user,
                    friendId: allFriendsSearch[index]['uid'],
                    friendName: allFriendsSearch[index]['name'],
                    friendImage: allFriendsSearch[index]['image'])));
              }, icon: Icon(Icons.message)),
            );
          }));


  }
}