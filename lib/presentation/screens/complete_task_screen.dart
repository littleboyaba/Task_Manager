import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controller/complete_task_controller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/empty_list_widget.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CompletedTaskController>().getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: GetBuilder<CompletedTaskController>(
            builder: (completedTaskController) {
          return Visibility(
            visible: completedTaskController.inProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),

            /// Todo: Make it work
            child: RefreshIndicator(
              onRefresh: () async {
                completedTaskController.getCompletedTaskList();
              },
              child: Visibility(
                visible: completedTaskController
                        .completedTaskListWrapper.taskList?.isNotEmpty ??
                    false,
                replacement: const EmptyListWidget(),
                child: ListView.builder(
                    itemCount: completedTaskController
                            .completedTaskListWrapper.taskList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskItem: completedTaskController
                            .completedTaskListWrapper.taskList![index],
                        refreshList: () {
                          completedTaskController.getCompletedTaskList();
                        },
                      );
                    }),
              ),
            ),
          );
        }),
      ),
    );
  }
}
