import 'package:chat_app/UI/homescreen/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/user.dart';
class Registerscreen extends StatefulWidget {
  static final ROUTE_NAME = 'registerscreen';

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final _formKey = GlobalKey<FormState>();


  String name = '';

  String email = '';

  String password = '';

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
                    'Create Account',
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
                                  name = newtext;
                                },
                                decoration: InputDecoration(
                                    labelText: 'First name'),
                              ),
                              TextFormField(
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                }, onChanged: (newtext) {
                                email = newtext;
                              },
                                decoration:
                                InputDecoration(labelText: 'E-mail Adress'),
                              ), TextFormField(
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  return null;
                                }, onChanged: (newtext) {
                                password = newtext;
                              },
                                decoration:
                                InputDecoration(labelText: 'Password'),
                              ),
                              SizedBox(
                                height: 70,
                              ),
                              isloading
                                  ? Center(child: CircularProgressIndicator())
                                  : SizedBox(
                                height: 60,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                         cerateaccount();
                                        Navigator.pushReplacementNamed(
                                            context, homescreen.ROUTE_NAME);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'Create Account ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16),
                                        ),
                                        Spacer(),
                                        Icon(Icons.arrow_forward)
                                      ],
                                    )),
                              ),

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
  bool isloading=false;
  final db = FirebaseFirestore.instance;
void cerateaccount()async{
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password:password

    );
    final userref = FirebaseFirestore.instance.collection(userss.COLLECTION_NAME).withConverter<userss>(
      fromFirestore: (snapshot, _) => userss.fromJson(snapshot.data()!),
      toFirestore: (userss, _) => userss.toJson(),
    );
    final user=userss(email: email, id: userCredential.user!.uid, username: name);
     userref.add(user ).then((value) => {
       print(value.toString())
     });

    showerror('user register sucssefully');
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      showerror(e.message.toString());}
  } catch (e) {
    print(e);
  }
}
  void showerror(String message){
    showDialog(context: context, builder: (context){
      return AlertDialog(content: Text(message),
        actions: [
          TextButton(onPressed: (){Navigator.pop(context);}, child:Text('ok') )
        ],);
    });

  }
}