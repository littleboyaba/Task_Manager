import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/presentation/controller/auth_controller.dart';
import 'package:task_manager/presentation/controller/update_profile_controller.dart';
import 'package:task_manager/presentation/widgets/background_widget.dart';
import 'package:task_manager/presentation/widgets/profile_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UpdateProfileController _updateProfileController = Get.find<UpdateProfileController>();
  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    _emailTEController.text = AuthController.userData?.email ?? '';
    _firstNameTEController.text = AuthController.userData?.firstName ?? '';
    _lastNameTEController.text = AuthController.userData?.lastName ?? '';
    _mobileTEController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: GetBuilder<UpdateProfileController>(
          builder: (updateProfileController){
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 48),
                      Text("Update Profile",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 24)),
                      const SizedBox(height: 16),
                      imagePickerButton(),
                      const SizedBox(height: 8),
                      TextFormField(
                        enabled: false,
                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Email",
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _firstNameTEController,
                        decoration: const InputDecoration(
                          hintText: "First Name",
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your First Name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _lastNameTEController,
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your Last Name";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _mobileTEController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: "Mobile",
                        ),
                        validator: (String? value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter your Mobile";
                          }
                          return null;
                        },
                        maxLength: 11,
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _passwordTEController,
                        decoration: const InputDecoration(
                          hintText: "Password (Optional)",
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: Visibility(
                          visible: _updateProfileController.inProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _updateProfileController.getUpdateProfile(_emailTEController.text.trim(), _firstNameTEController.text.trim(), _lastNameTEController.text.trim(), _mobileTEController.text.trim(), _passwordTEController.text, _pickedImage);
                              }
                            },
                            child: const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget imagePickerButton() {
    return GestureDetector(
      onTap: () {
        pickImageFromGallery();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: const Text(
                "Photo",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                _pickedImage?.name ?? '',
                maxLines: 1,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
