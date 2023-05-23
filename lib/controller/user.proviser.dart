import 'package:flutter/cupertino.dart';

import '../models/dog.dart';
import '../models/dogf.dart';
import '../models/user.dart';

class Security with ChangeNotifier {
  String authorization = "";
  changeAuthorization(String authorizationNew) {
    authorization = authorizationNew;
    notifyListeners();
  }

  UserLogin user = UserLogin();
  changeUser(UserLogin newUser) {
    user = newUser;
    notifyListeners();
  }

  List<DogF> listDogF = [];
  changeListGodF(List<DogF> newlist) {
    listDogF = newlist;
    notifyListeners();
  }

}
