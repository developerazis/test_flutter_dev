import 'package:flutter/material.dart';

import '../../model/user_response_model.dart';

class OrderProvider extends ChangeNotifier {
  User? user;

  search() {
    user = User.fromJson({
      "id": 2,
      "email": "janet.weaver@reqres.in",
      "first_name": "Janet",
      "last_name": "Weaver",
      "avatar": "https://reqres.in/img/faces/2-image.jpg"
    });
    notifyListeners();
  }
}