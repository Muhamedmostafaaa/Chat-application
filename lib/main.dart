
import 'package:chat_app/UI/homescreen/homescreen.dart';
import 'package:chat_app/UI/loginscreen/loginscreen.dart';
import 'package:chat_app/UI/registerscreen/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(myapp());
}
class myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
          return MaterialApp(

            routes: {
              loginscreen.ROUTE_NAME:(context)=>loginscreen(),
              Registerscreen.ROUTE_NAME:(context)=>Registerscreen(),
              homescreen.ROUTE_NAME:(context)=>homescreen()
            },
            initialRoute: Registerscreen.ROUTE_NAME,
          );


  }

}