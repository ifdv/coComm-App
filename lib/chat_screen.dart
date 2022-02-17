import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:co_comm/constants.dart';


class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedUser;
  late String messageText;

  void initState(){
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser()async{
    try{
      final user = await _auth.currentUser;
      if(user != null)
        loggedUser = user;
    }catch(e){

    }
  }
  void getMessages() async {
    final messages = await _firestore.collection('messages').get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            onPressed: (){} , icon: Icon(Icons.close),),
        ],
        title: Text('Chat'),
        backgroundColor: btnColor,

      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value){
                        messageText = value;
                      },
                      decoration: kMessageTextField,
                    ),
                  ),
                TextButton(onPressed: () async{
                  await _firestore.collection('messages').add({
                    'sender': loggedUser,
                    'text': messageText,
                  });
                }, child: Text('Send', style: kSendButtonTextStyle,))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
