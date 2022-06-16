
import 'package:chat_app/UI/add%20room/addroom.dart';
import 'package:chat_app/UI/homescreen/homescreen.dart';
import 'package:chat_app/UI/homescreen/roomdetails.dart';
import 'package:chat_app/UI/loginscreen/loginscreen.dart';
import 'package:chat_app/UI/provider/appprovider.dart';
import 'package:chat_app/UI/registerscreen/registerscreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseMessaging messaging = FirebaseMessaging.instance;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
  printtoken();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(myapp());
}
void printtoken()async{
  String? token = await messaging.getToken();
  print('token $token');
}

class myapp extends StatefulWidget{
  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  initState(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }
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