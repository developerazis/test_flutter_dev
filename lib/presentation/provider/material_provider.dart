import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_maha_dev/repository/material_repository.dart';

import '../../model/user_response_model.dart';

class MaterialProvider extends ChangeNotifier {
  bool isLoading = false;
  List<User> data = [];
  final MaterialRepository materialRepository = MaterialRepository();
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController stockController = TextEditingController();

  MaterialProvider() {
    Future.delayed(Duration.zero, () async {
      try {
        isLoading = true;
        notifyListeners();

       UserResponse? response = await materialRepository.getUser(limit: 12);

       if (response?.data?.isNotEmpty ?? false) {
         data = response?.data ?? [];
       }

        isLoading = false;
        notifyListeners();
      } catch (error) {
        if (kDebugMode) print(error);
      }
    });
  }

  Future<bool> createUser() async {
    if (nameController.text.isNotEmpty && stockController.text.isNotEmpty) {
      User? user = await materialRepository.createUser(
          name: nameController.text,
          job: jobController.text
      );

      if (user != null) {
        data.add(User(
            id: user.id,
            firstName: nameController.text,
            stock: int.parse(stockController.text)));
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<bool> updateUser(String id) async {
    if (nameController.text.isNotEmpty && stockController.text.isNotEmpty) {
      User? user = await materialRepository.updateUser(
          name: nameController.text,
          job: jobController.text,
          id: id
      );

      if (user != null) {
        int index = data.indexWhere((element) => element.id == int.parse(id));
        if (index > -1) {
          data[index].lastName = nameController.text;
          data[index].job = jobController.text;
          data[index].stock = int.parse(stockController.text);

          notifyListeners();
          return true;
        }
      }
    }
    return false;
  }

  Future<bool> deleteUser(String id) async {
    data.removeWhere((element) => element.id == int.parse(id));
    notifyListeners();
    return true;
  }
}