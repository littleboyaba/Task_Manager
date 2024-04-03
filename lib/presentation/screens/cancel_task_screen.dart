import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import '../controller/cancel_task_controller.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_card.dart';

class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CancelTaskController>().getCanceledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child:
            GetBuilder<CancelTaskController>(builder: (cancelTaskController) {
          return Visibility(
            visible: cancelTaskController.inProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                cancelTaskController.getCanceledTaskList();
              },
              child: Visibility(
                visible: cancelTaskController
                        .canceledTaskListWrapper.taskList?.isNotEmpty ??
                    false,
                replacement: const EmptyListWidget(),
                child: ListView.builder(
                    itemCount: cancelTaskController
                            .canceledTaskListWrapper.taskList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return TaskCard(
                          taskItem: cancelTaskController
                              .canceledTaskListWrapper.taskList![index],
                          refreshList: () {
                            cancelTaskController.getCanceledTaskList();
                          });
                    }),
              ),
            ),
          );
        }),
      ),
    );
  }
}
