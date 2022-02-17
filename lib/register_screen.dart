import 'package:flutter/material.dart';
import 'package:co_comm/rounded_button.dart';
import 'package:co_comm/chat_screen.dart';
import 'package:co_comm/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'register_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool showSpinner = false;
  late String email;
  late String password;
  late String username;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bcgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200,
                    child: Icon(
                      Icons.person,
                      size: 200,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              Text(
                'Registration page',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Comfortaa',
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 48,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  username = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Username',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                    )),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'example@gmail.com',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                    )),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: '••••••••••',
                    hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                    )),
                obscureText: true,
              ),
              RoundedButton(
                title: 'Register',
                color: btnColor,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    print(newUser.user);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
