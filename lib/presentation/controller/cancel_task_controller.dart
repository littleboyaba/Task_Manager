import 'package:get/get.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';
import 'package:task_manager/data/services/network_caller.dart';

import '../../data/utility/urls.dart';

class CancelTaskController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;
  TaskListWrapper _canceledTaskListWrapper = TaskListWrapper();

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Get canceled task list has been failed';
  TaskListWrapper get canceledTaskListWrapper => _canceledTaskListWrapper;

  Future<bool> getCanceledTaskList() async{
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.canceledTaskList);
    if(response.isSuccess){
      _canceledTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
    }else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}