import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/presentation/controller/add_new_task_controller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AddNewTaskController _addNewTaskController =
      Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
       Navigator.pop(context, _addNewTaskController.shouldRefreshNewTaskList);
      },
      child: Scaffold(
        appBar: profileAppBar,
        body: BackgroundWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 48),
                    Text("Add New Task",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 24)),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleTEController,
                      decoration: const InputDecoration(
                        hintText: "Title",
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your title";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _descriptionTEController,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        hintText: "Description",
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return "Enter your description";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<AddNewTaskController>(
                        builder: (addNewTaskController) {
                          return Visibility(
                            visible: addNewTaskController.inProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _addNewTask();
                                }
                              },
                              child:
                                  const Icon(Icons.arrow_circle_right_outlined),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async {
    final result = await _addNewTaskController.getAddNewTask(
        _titleTEController.text.trim(),
        _descriptionTEController.text.trim(),
        "New");
    if (result) {
      _addNewTaskController.shouldRefreshNewTaskList == true;
      _titleTEController.clear();
      _descriptionTEController.clear();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }
}
