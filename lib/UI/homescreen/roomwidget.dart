import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../model/room.dart';

class Roomwidget extends StatelessWidget{
  Room room;
  Roomwidget(this.room);
  @override
  Widget build(BuildContext context) {
   return Container(padding: EdgeInsets.all(10),
     decoration:BoxDecoration(color: Colors.white,
     borderRadius: BorderRadius.circular(15),boxShadow: [BoxShadow(
           offset: Offset(4,4),color: Colors.black26,blurRadius: 4
         )]
     ),
     child: Column(
       children: [
       Image(image: AssetImage('assets/images/${room.categroy}.png'),fit: BoxFit.fill,height: 120,),
         Text(room.roomname,style:TextStyle(fontSize: 22,fontWeight:FontWeight.w600),),
       ],
     ),
   );
  }

}