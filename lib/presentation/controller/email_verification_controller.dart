import 'package:get/get.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/screens/auth/pin_verification_screen.dart';

class EmailVerificationController extends GetxController{
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Email verify has been failed';


  Future<bool> getEmailVerify(String email) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller.getRequest(Urls.verifyEmail(email));
    if(response.isSuccess){
      // Get.to(() => PinVerificationScreen(email: email));
      isSuccess = true;
    }else{
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}