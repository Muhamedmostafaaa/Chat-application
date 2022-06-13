import 'package:flutter/widgets.dart';

import '../../model/user.dart';

class app_provider extends ChangeNotifier{
  userss? currentuser ;
  void updateuser (userss user){
    currentuser=user;
    notifyListeners();
  }
}