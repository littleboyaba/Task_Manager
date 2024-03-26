import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_wrapper.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';


class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  bool _getAllCanceledTaskListInProgress = false;
  TaskListWrapper _canceledTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllCanceledTaskList();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Visibility(
          visible: _getAllCanceledTaskListInProgress == false,
          replacement: const Center(child: CircularProgressIndicator(),),
          child: RefreshIndicator(
            onRefresh: () async {
              _getAllCanceledTaskList();
            },
            child: Visibility(
              visible: _canceledTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: const EmptyListWidget(),
              child: ListView.builder(
                  itemCount: _canceledTaskListWrapper.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskCard(taskItem: _canceledTaskListWrapper.taskList![index], refreshList: (){
                      _getAllCanceledTaskList();
                    });
                    } ),
            ),
          ),
          ),
        ),
      );
  }

  Future<void> _getAllCanceledTaskList() async {
    _getAllCanceledTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.canceledTaskList);

    if (response.isSuccess) {
      _canceledTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      _getAllCanceledTaskListInProgress = false;
      setState(() {});
    } else {
      _getAllCanceledTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get canceled task list has been failed');
      }
    }
  }
}
