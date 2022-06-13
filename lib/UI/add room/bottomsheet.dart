import 'package:flutter/material.dart';

class bottomsheet extends StatefulWidget {
  @override
  Function thecategroyselected;
  bottomsheet(this.thecategroyselected);
  State<bottomsheet> createState() => _bottomsheetState();
}

class _bottomsheetState extends State<bottomsheet> {
  String selectedcategory = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [getmainview('music'),getmainview('sports'),getmainview('movies')],
        ),
      ),
    );
  }

  Widget getmainview(String text) {
    return Row(
      children: [
        TextButton(
          child: Text(text, style: TextStyle(fontSize: 16,color: selectedcategory==text?Colors.blue:Colors.black,)),
          onPressed: () {

            setState((){
              selectedcategory=text;
              widget.thecategroyselected(text);
            });
          },
        ),Spacer(),
        selectedcategory==text?Icon(Icons.check,color: selectedcategory==text?Colors.blue:Colors.black,):Container()
      ],
    );
  }
}
