
import 'package:chat_app/UI/add%20room/addroom.dart';
import 'package:chat_app/UI/homescreen/homescreen.dart';
import 'package:chat_app/UI/homescreen/roomdetails.dart';
import 'package:chat_app/UI/loginscreen/loginscreen.dart';
import 'package:chat_app/UI/provider/appprovider.dart';
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
          return ChangeNotifierProvider(
            create: (context)=> app_provider(),
            builder: (context, widget ){
              final provider = Provider.of<app_provider>(context);
            return   MaterialApp(

                routes: {
                  loginscreen.ROUTE_NAME:(context)=>loginscreen(),
                  Registerscreen.ROUTE_NAME:(context)=>Registerscreen(),
                  homescreen.ROUTE_NAME:(context)=>homescreen(),
                  addroom.ROUTE_NAME:(context)=>addroom(),
                  Roomdetails.ROUTE_NAME:(context)=>Roomdetails()
                },
                initialRoute:provider.islogin()? homescreen.ROUTE_NAME:loginscreen.ROUTE_NAME,
              );
            },
          );


  }

}