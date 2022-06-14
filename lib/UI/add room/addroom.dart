import 'package:chat_app/UI/add%20room/bottomsheet.dart';
import 'package:chat_app/UI/homescreen/homescreen.dart';
import 'package:chat_app/database_helper/database.dart';
import 'package:chat_app/model/room.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

 class addroom extends StatefulWidget {
  static const String ROUTE_NAME = 'addroom';

  @override
  State<addroom> createState() => _addroomState();
}

class _addroomState extends State<addroom> {
   String roomname='';
   String description='';
   String selectedcategory='';
   final _formKey = GlobalKey<FormState>();
  late  String categroy;
   initState(){
    categroy='';
   }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
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
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 24,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              'Chat App',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true),
        body: Center(
          child: Container(padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(vertical: 32, horizontal: 12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(4, 8),
                      blurRadius: 4)
                ]),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                 const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Create New Room',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                ),
                Image.asset('assets/images/newroom_logo.png'),
                Form(key: _formKey,
                    child:
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(onChanged: (newtext){
                            roomname=newtext;
                          },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                              decoration: InputDecoration(labelText: 'Enter Room Name')
                          ),TextFormField(
                            onChanged: (newtext){
                              description=newtext;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                              decoration: InputDecoration(labelText: 'Enter Room Description')
                          ),
                          ElevatedButton(onPressed: (){
                            openbottomsheet();
                          }, child: Text(categroy.isEmpty?'chosse room categroy':categroy,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),),
                          SizedBox(height: 50,),
                         TextButton(onPressed: (){
                           if (_formKey.currentState!.validate()) {
                             if (categroy != '') {
                               createroom();
                             }
                             else {
                               Showerror('please select room category');

                             }
                           }
                         }, child: Text('Create',style: TextStyle(fontSize: 20),))
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      )
    ]);
  }

  void openbottomsheet(){
    showModalBottomSheet(context: context, builder: (context){
      return bottomsheet(categroyselected);
    });
  }
  void categroyselected(String text ){
    print(text);
    selectedcategory=text;
    setState((){
      categroy=text;
    });

  }
  void createroom(){
    final docref= get_room_ref_with_converter().doc();
     Room room=Room(categroy: categroy, id:docref.id, roomname: roomname, description: description);
     docref.set(room).then((value)
     {
       Fluttertoast.showToast(msg: 'the room added sucssefully',
         toastLength: Toast.LENGTH_LONG,



       );
       Navigator.pushReplacementNamed(context,homescreen.ROUTE_NAME);
     }
     );

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
