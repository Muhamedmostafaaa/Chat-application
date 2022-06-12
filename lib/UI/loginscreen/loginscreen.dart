import 'package:chat_app/UI/homescreen/homescreen.dart';
import 'package:chat_app/UI/registerscreen/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginscreen extends StatefulWidget {
  static final ROUTE_NAME = 'LOGINSCREEN';

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {
  final _formKey = GlobalKey<FormState>();

  String email = '';

  String passowrd = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Image.asset(
            'assets/images/back_ground.png',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 30,
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  centerTitle: true,
                ),
                SizedBox(
                  height: 150,
                ),
                Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Welcome back !',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onChanged: (newtext) {
                                  email = newtext;
                                },
                                decoration: InputDecoration(labelText: 'Email'),
                              ),
                              TextFormField(
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                },
                                onChanged: (newtext) {
                                  passowrd = newtext;
                                },
                                decoration:
                                    InputDecoration(labelText: 'Password'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        login();
                                        Navigator.pushReplacementNamed(
                                            context, homescreen.ROUTE_NAME);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Login ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    )),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, Registerscreen.ROUTE_NAME);
                                  },
                                  child: Text(
                                    'Or Create My Account',
                                    style: TextStyle(
                                        color: Color(0xff505050),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300),
                                    textAlign: TextAlign.start,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }

  void login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: passowrd,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Showerror('no user found for this email');
      } else if (e.code == 'wrong-password') {
        Showerror('wrong password please enter again');
      }
    }
  }

  void Showerror(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'))
            ],
          );
        });
  }
}
