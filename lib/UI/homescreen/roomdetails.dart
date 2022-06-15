import 'package:chat_app/UI/homescreen/messagedesign.dart';
import 'package:chat_app/UI/provider/appprovider.dart';
import 'package:chat_app/database_helper/database.dart';
import 'package:chat_app/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/message.dart';

class Roomdetails extends StatefulWidget {
  static const String ROUTE_NAME = 'roomdetails';

  @override
  State<Roomdetails> createState() => _RoomdetailsState();
}

class _RoomdetailsState extends State<Roomdetails> {
  late CollectionReference<Message>messageref;

  late DocumentReference<Message>messagedocref;

  late app_provider provider;

  String messagecontent = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute
        .of(context)!
        .settings
        .arguments as Room;

    messageref = get_message_ref_with_converter(args.id);
    messagedocref = messageref.doc();
    final Stream<QuerySnapshot<Message>> messagestream=messageref.orderBy('time').snapshots();
    provider = Provider.of<app_provider>(context);

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
                args.roomname,
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true),
          body: Center(
              child: Expanded(
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(vertical: 32, horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          const BoxShadow(
                              color: Colors.black26,
                              offset: Offset(4, 8),
                              blurRadius: 4)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                            child: Text('Today', style: TextStyle(color: Color(
                                0Xff7F7F7F), fontSize: 18),)),
                        Spacer(),
                        Expanded(flex: 7,
                          child: Container(color:Colors.red,height: double.infinity,width:double.infinity,
                            child: StreamBuilder<QuerySnapshot<Message>>(
                              stream: messagestream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot<Message>> snapshot) {
                                if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                } else if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemBuilder: (context, index) {
                                      return messagedesign(snapshot.data!.docs[index].data());
                                    }, itemCount: snapshot.data?.size,reverse: true,);
                                } else
                                  return Center(
                                    child: CircularProgressIndicator(),);
                              },
                            ),
                          ),
                        ),

                        Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                onChanged: (newtext) {
                                  messagecontent = newtext;
                                },
                                controller: controller,

                                decoration: InputDecoration(
                                    hintText: 'Type you message',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20)))),
                              ),
                            ),
                            SizedBox(width: 20,),
                            InkWell(onTap: () {
                              create();
                            },
                              child: Container(height: 40,
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10))
                                ),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Send', style: TextStyle(
                                        color: Colors.white, fontSize: 14)),
                                    SizedBox(width: 20
                                      ,),
                                    Icon(Icons.send, color: Colors.white,
                                      size: 18,)
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              )))
    ]);
  }

  void create() {
    Message message = Message(senderid: provider.currentuser!.id,
        id: messagedocref.id,
        content: messagecontent,
        time: DateTime
            .now()
            .millisecondsSinceEpoch,
        sendername: provider.currentuser!.username);
    messagedocref.set(message).then((value) =>
        setState(() {
          messagecontent = '';
          controller.clear();
        })
    );
  }
}
