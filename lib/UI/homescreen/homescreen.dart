import 'package:chat_app/UI/add%20room/addroom.dart';
import 'package:chat_app/UI/homescreen/roomwidget.dart';
import 'package:chat_app/UI/loginscreen/loginscreen.dart';
import 'package:chat_app/UI/provider/appprovider.dart';
import 'package:chat_app/database_helper/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/room.dart';

class homescreen extends StatelessWidget {
  static final ROUTE_NAME = 'HOMESCREEN';

  @override
  Widget build(BuildContext context) {
    final roomcollectionref = get_room_ref_with_converter();
    final provider=Provider.of<app_provider>(context);
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, addroom.ROUTE_NAME);
          },
          child: Icon(
            Icons.add,
            size: 35,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    size: 35,
                  ),
                )
              ],
              leading: InkWell(onTap: (){
                FirebaseAuth.instance.signOut();
                provider.updateuser(null);
                Navigator.pushReplacementNamed(context, loginscreen.ROUTE_NAME);

              },
                child: Icon(
                  Icons.table_rows,
                  size: 35,
                ),
              ),
              title: Text(
                'Chat App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            Expanded(
              child: Container(margin: EdgeInsets.symmetric(vertical: 38,horizontal: 20),

                child: FutureBuilder<QuerySnapshot<Room>>(
                    future: roomcollectionref.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot<Room>> snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        final roomlist = snapshot.data!.docs
                            .map((singledoc) => singledoc.data())
                            .toList();
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 4,
                                  crossAxisSpacing: 4),
                          itemBuilder: (context, index) {
                            return Roomwidget(roomlist[index]);
                          },
                          itemCount: roomlist.length,
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            )
          ],
        ),
      ),
    ]);
  }
}
