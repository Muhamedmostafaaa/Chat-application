import 'package:chat_app/UI/add%20room/bottomsheet.dart';
import 'package:flutter/material.dart';

 class addroom extends StatefulWidget {
  static const String ROUTE_NAME = 'addroom';

  @override
  State<addroom> createState() => _addroomState();
}

class _addroomState extends State<addroom> {
   String categroy='';
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
                 SizedBox(
                  height: 20,
                ),
                Text(
                  'Create New Room',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                ),
                Image.asset('assets/images/newroom_logo.png'),
                Form(child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                            decoration: InputDecoration(labelText: 'Enter Room Name')
                        ),TextFormField(
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
                       TextButton(onPressed: (){}, child: Text('Create',style: TextStyle(fontSize: 20),))
                      ],
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
    setState((){
      categroy=text;
    });

  }
}
