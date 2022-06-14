import 'package:chat_app/database_helper/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

import '../../model/user.dart';

class app_provider extends ChangeNotifier{
  userss? currentuser ;

  bool islogin(){
    final firebaseuser=FirebaseAuth.instance.currentUser;
    if(firebaseuser!=null){

      get_user_ref_with_converter().doc(firebaseuser.uid).get().then((retriveduser) {
        currentuser=retriveduser.data();


      } );
    }
    return firebaseuser!=null;
  }

  void updateuser (userss? user){
    currentuser=user;
    notifyListeners();
  }
}