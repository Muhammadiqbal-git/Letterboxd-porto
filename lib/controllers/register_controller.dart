import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  Rx<TextEditingController> usernameText = TextEditingController().obs;
  Rx<TextEditingController> emailText = TextEditingController().obs;
  Rx<TextEditingController> passText = TextEditingController().obs;

  @override
  void onClose() {
    usernameText.value.dispose();
    passText.value.dispose();
    super.onClose();
  }

  void register() {
    print(emailText.value.text);
  }
}
