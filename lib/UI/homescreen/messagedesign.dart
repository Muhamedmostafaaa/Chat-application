import 'package:chat_app/model/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class messagedesign extends StatelessWidget {
  Message message;
  messagedesign(this.message);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(width:double.infinity,
            padding: EdgeInsets.all(25),margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
            child: Text(message.content),
          ),
        ),
        Text(format(message.time))
      ],
    );
  }
  String format(var time){
    var formattedDate = DateFormat('kk:mm a');
     return formattedDate.format(DateTime.fromMillisecondsSinceEpoch(time));
  }
}
