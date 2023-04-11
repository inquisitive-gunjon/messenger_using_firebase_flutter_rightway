import 'package:cached_network_image/cached_network_image.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../widgets/message_textfield.dart';
import '../widgets/single_message.dart';

class ChatScreen extends StatelessWidget {

  // we show the details here...
  final UserModel currentUser;
  final String friendId;
  final String friendName;
  final String friendImage;
  
  ChatScreen({
    required this.currentUser,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
  });
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child:  CachedNetworkImage(
                            imageUrl:friendImage,
                            placeholder: (conteext,url)=>CircularProgressIndicator(),
                            errorWidget: (context,url,error)=>Icon(Icons.error,),
                            height: 40,
                          ),
            ),
            const SizedBox(width: 5,),
            Text(friendName,style: TextStyle(fontSize: 20),)
          ],
        ),
      ),

      body: Column(
        children: [
           Expanded(child: Container(
             padding: EdgeInsets.all(10),
             decoration: const BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(25),
                 topRight: Radius.circular(25)
               )
             ),

             // data fetch from firebase ..........
             child: StreamBuilder(
               stream: FirebaseFirestore.instance.collection("users").doc(currentUser.uid).collection('messages').doc(friendId).collection('chats').orderBy("date",descending: true).snapshots(),
               builder: (context,AsyncSnapshot snapshot){
                   if(snapshot.hasData){
                     if(snapshot.data.docs.length < 1){
                       return const Center(
                         child: Text("Say Hi"),
                       );
                     }
                     return ListView.builder(
                       itemCount: snapshot.data.docs.length,
                       reverse: true,
                       physics: BouncingScrollPhysics(),
                       itemBuilder: (context,index){
                          bool isMe = snapshot.data.docs[index]['senderId'] == currentUser.uid;
                          return SingleMessage(message: snapshot.data.docs[index]['message'], isMe: isMe);
                       });
                   }
                   return const Center(
                     child: CircularProgressIndicator()
                   );
               }),
           )),
           MessageTextField(currentUser.uid, friendId),
        ],
      ),
      
    );
  }
}