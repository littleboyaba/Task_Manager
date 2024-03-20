import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_item.dart';
import 'package:task_manager/presentation/widgets/snack_bar_message.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    Key? key,
    required this.taskItem,
    required this.refreshList,
  }) : super(key: key);

  final TaskItem taskItem;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _updateTaskStatusInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskItem.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.taskItem.description ?? ''),
            Text('Date: ${widget.taskItem.createdDate}'),
            Row(
              children: [
                Chip(label: Text(widget.taskItem.status ?? '')),
                const Spacer(),
                Visibility(
                  visible: _updateTaskStatusInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                      onPressed: (){
                        _showUpdateStatusDialog(widget.taskItem.sId!);
                      }, icon: const Icon(Icons.edit)),
                ),
                Visibility(
                  visible: _deleteTaskInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                      onPressed: () {
                        _deleteTaskById(widget.taskItem.sId!);
                      },
                      icon: const Icon(Icons.delete_outline)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateStatusDialog(String id) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Select Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ListTile(
                  title: Text('New'),
                  trailing: Icon(Icons.check),
                ),
                ListTile(
                  title: const Text('Completed'),
                  onTap: () {
                    _updateTaskById(id, 'Completed');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Canceled'),
                  onTap: () {
                    _updateTaskById(id, 'Canceled');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Progress'),
                  onTap: () {
                    _updateTaskById(id, 'Progress');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });

  }

  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskStatusInProgress = true;
    setState(() {});
    final response =
    await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    _updateTaskStatusInProgress = false;
    if (response.isSuccess) {
      _updateTaskStatusInProgress = false;
      widget.refreshList();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Update task status has been failed');
      }
    }
  }
  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    _deleteTaskInProgress = false;

    if (response.isSuccess) {
      widget.refreshList();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Delete task has been failed');
      }
    }
  }

}
