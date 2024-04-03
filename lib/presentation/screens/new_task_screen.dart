import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controller/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/controller/new_task_controller.dart';
import 'package:task_manager/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager/presentation/utils/app_colors.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import '../../data/models/task_count_by_status_data.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_counter_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {_getDataFromApis(); });

  }

  void _getDataFromApis() async {
    await Get.find<CountTaskByStatusController>().getCountByStatus();
    await Get.find<NewTaskController>().getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            GetBuilder<CountTaskByStatusController>(
              builder: (countTaskByStatusController) {
                return Visibility(
                    visible: countTaskByStatusController.inProgress == false,
                    replacement: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: LinearProgressIndicator()),
                    child: taskCounterSection(countTaskByStatusController
                            .countByStatusWrapper.listOfTaskByStatusData ??
                        []));
              },
            ),
            Expanded(
              child: GetBuilder<NewTaskController>(
                builder: (newTaskController) {
                  return Visibility(
                    visible: newTaskController.inProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () async => _getDataFromApis(),
                      child: Visibility(
                        visible: newTaskController
                                .newTaskListWrapper.taskList?.isNotEmpty ??
                            false,
                        replacement: const EmptyListWidget(),
                        child: ListView.builder(
                            itemCount: newTaskController
                                    .newTaskListWrapper.taskList?.length ??
                                0,
                            itemBuilder: (context, index) {
                              return TaskCard(
                                taskItem: newTaskController
                                    .newTaskListWrapper.taskList![index],
                                refreshList: () {
                                  _getDataFromApis();
                                },
                              );
                            }),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /// Todo: Recall the home apis after successfully add new task/tasks
          final result = await Get.to(() => const AddNewTaskScreen());
          if (result != null && result == true) {
            // If successful, recall the home APIs
            _getDataFromApis();
          }
        },
        backgroundColor: AppColors.themeColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget taskCounterSection(
      List<TaskCountByStatusData> listOfTaskByStatusData) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: listOfTaskByStatusData.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              title: listOfTaskByStatusData[index].sId ?? '',
              amount: listOfTaskByStatusData[index].sum ?? 0,
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(width: 8);
          },
        ),
      ),
    );
  }
}
