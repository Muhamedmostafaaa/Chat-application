import 'package:flutter/material.dart';

class homescreen extends StatelessWidget {
  static final ROUTE_NAME='HOMESCREEN';
  @override
  Widget build(BuildContext context) {
    return
      Stack(children: [

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
          floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add,size: 35,),),
          backgroundColor:Colors.transparent,




          body: Column(
            children: [

              SizedBox(height: 20,),
              AppBar(actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.search,size: 35,),
                )
              ],
                leading: Icon(Icons.table_rows,size: 35,),
                title: Text('Chat App',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),),centerTitle: true,
                backgroundColor:Colors.transparent,elevation: 0,
              ),
            ],
          ),
        ),



      ]);
  }
}
