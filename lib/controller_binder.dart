import 'package:get/get.dart';
import 'package:task_manager/presentation/controller/add_new_task_controller.dart';
import 'package:task_manager/presentation/controller/cancel_task_controller.dart';
import 'package:task_manager/presentation/controller/complete_task_controller.dart';
import 'package:task_manager/presentation/controller/count_task_by_status_controller.dart';
import 'package:task_manager/presentation/controller/email_verification_controller.dart';
import 'package:task_manager/presentation/controller/new_task_controller.dart';
import 'package:task_manager/presentation/controller/progress_task_controller.dart';
import 'package:task_manager/presentation/controller/sign_in_controller.dart';
import 'package:task_manager/presentation/controller/sign_up_controller.dart';
import 'package:task_manager/presentation/controller/update_profile_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SignInController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => CountTaskByStatusController(), fenix: true);
    Get.lazyPut(() => NewTaskController(), fenix: true);
    Get.lazyPut(() => CompletedTaskController(), fenix: true);
    Get.lazyPut(() => CancelTaskController(), fenix: true);
    Get.lazyPut(() => ProgressTaskController(), fenix: true);
    Get.lazyPut(() => AddNewTaskController(), fenix: true);
    Get.lazyPut(() => UpdateProfileController(), fenix: true);
    Get.lazyPut(() => EmailVerificationController(), fenix: true);
  }
}