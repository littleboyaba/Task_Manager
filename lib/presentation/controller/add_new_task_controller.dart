import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';

import '../../data/utility/urls.dart';

class AddNewTaskController extends GetxController {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController = TextEditingController();
  bool _inProgress = false;
  bool _shouldRefreshNewTaskList = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  bool get shouldRefreshNewTaskList => _shouldRefreshNewTaskList;
  String get errorMessage => _errorMessage ?? 'Add new task failed!';

  Future<bool> getAddNewTask(
      String title, String description, String status) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "title": title,
      "description": description,
      "status": status,
    };

    final response =
        await NetworkCaller.postRequest(Urls.createTask, inputParams);
    if (response.isSuccess) {
      _shouldRefreshNewTaskList = true;
      _titleTEController.clear();
      _descriptionTEController.clear();
      Get.snackbar("Successful", "New task has been added",
          // backgroundColor: Colors.grey,
          animationDuration: const Duration(milliseconds: 300),
          snackPosition: SnackPosition.BOTTOM);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
