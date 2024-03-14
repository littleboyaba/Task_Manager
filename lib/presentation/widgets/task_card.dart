import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_item.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.taskItem,
  });

  final TaskItem taskItem;

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
              taskItem.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(taskItem.description ?? ''),
            Text('Date: ${taskItem.createdDate}'),
            Row(
              children: [
                Chip(label: Text(taskItem.status ?? '')),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.delete_outline)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
