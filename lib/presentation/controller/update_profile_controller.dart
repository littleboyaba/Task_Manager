import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/user_data.dart';
import 'package:task_manager/data/services/network_caller.dart';
import 'package:task_manager/data/utility/urls.dart';
import 'package:task_manager/presentation/controller/auth_controller.dart';
import 'package:task_manager/presentation/screens/main_bottom_nav_screen.dart';

class UpdateProfileController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;
  XFile? _pickedImage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Update profile has failed';
  XFile? get pickedImage => _pickedImage;
  final Rx<XFile?> _pickedImageRx = Rx<XFile?>(null);

  @override
  void onInit() {
    super.onInit();
    _pickedImageRx.bindStream(_pickedImageStream());
  }

  Stream<XFile?> _pickedImageStream() async* {
    yield _pickedImage;
  }

  Future<void> pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    _pickedImageRx.value = _pickedImage;
  }

  Future<bool> getUpdateProfile(String email, String firstName, String lastName, String mobile, String password, XFile? pickedImage) async {
    String? photo;
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password.isNotEmpty) {
      inputParams["password"] = password;
    }

    if (pickedImage != null) {
      List<int> bytes = await pickedImage.readAsBytes();
      photo = base64Encode(bytes);
      inputParams['photo'] = photo;
    }

    final response = await NetworkCaller.postRequest(Urls.updateProfile, inputParams);
    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
          email: email,
          firstName: firstName.trim(),
          lastName: lastName.trim(),
          mobile: mobile.trim(),
          photo: photo,
        );
        await AuthController.saveUserData(userData);
        isSuccess = true;
      }
      Get.offAll(() => const MainBottomNavScreen());
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
