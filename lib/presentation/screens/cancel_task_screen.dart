import 'package:flutter/material.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_card.dart';


class CancelTaskScreen extends StatefulWidget {
  const CancelTaskScreen({super.key});

  @override
  State<CancelTaskScreen> createState() => _CancelTaskScreenState();
}

class _CancelTaskScreenState extends State<CancelTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              // return const TaskCard();
            }),
      ),
    );
  }
}
