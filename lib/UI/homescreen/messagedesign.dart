import 'package:chat_app/UI/provider/appprovider.dart';
import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class messagedesign extends StatelessWidget {
  Message message;
  messagedesign(this.message);

  @override
  Widget build(BuildContext context) {
    final providr=Provider.of<app_provider>(context);
    return providr.currentuser?.id==message.senderid? Row(mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(format(message.time),textAlign: TextAlign.end,style: TextStyle(fontSize: 12),),
        Expanded(
          child: Container(width:double.infinity,
            padding: EdgeInsets.all(13),margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Text(message.content,style: TextStyle(fontSize: 18,color: Colors.white),textAlign: TextAlign.center,),
          ),
        )
      ],
    ):Row(
      children: [
        Expanded(
          child: Container(width:double.infinity,
            padding: EdgeInsets.all(13),margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Text(message.content,style: TextStyle(fontSize: 18,color: Color(0XFF787993)),textAlign: TextAlign.center,),
          ),
        ),
        Text(format(message.time),textAlign: TextAlign.end,style: TextStyle(fontSize: 12),),
      ],

    );
  }
  String format(var time){
    var formattedDate = DateFormat('kk:mm a');
     return formattedDate.format(DateTime.fromMillisecondsSinceEpoch(time));
  }
}
