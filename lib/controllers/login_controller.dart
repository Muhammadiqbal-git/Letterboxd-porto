import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

Rx<TextEditingController> usernameText = TextEditingController().obs;
Rx<TextEditingController> passText = TextEditingController().obs;

@override
  void onClose() {
    usernameText.value.dispose();
    passText.value.dispose();
    super.onClose();
  }
void login(){
  print(usernameText.value.text);
  print(passText.value.text);
}
}