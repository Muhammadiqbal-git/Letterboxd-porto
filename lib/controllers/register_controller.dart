import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/firebase_auth_services.dart';
import 'package:letterboxd_porto_3/exceptions/error.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_alert_dialog.dart';

import '../views/widgets/custom_loading_dialog.dart';

class RegisterController extends GetxController {
  final FirebaseAuthService _service = FirebaseAuthService();
  Rx<TextEditingController> usernameText = TextEditingController().obs;
  Rx<TextEditingController> emailText = TextEditingController().obs;
  Rx<TextEditingController> passText = TextEditingController().obs;
  Rx<User?> userData = Rx<User?>(null);
  Rx<RegisterState> registerState = RegisterState.loading.obs;
  late Worker ev;

  @override
  void onInit() {
    ev = ever(registerState, (state) {
      if (state == RegisterState.loading) {
        print("yes");
        Get.dialog(
          const CustomLoadingDialog(),
          barrierDismissible: false,
        );
      } else {
        Get.back();
        switch (state) {
          case RegisterState.error:
            Get.dialog(const CustomAlertDialog(
                text: "Connection Timeout, cek lagi internetnya"));
            break;
          case RegisterState.emptyText:
            Get.dialog(const CustomAlertDialog(
                text: "Username, email, atau password tidak boleh kosong"));
            break;
          case RegisterState.already:
            Get.dialog(const CustomAlertDialog(
                text:
                    "Email tidak dapat digunakan. Email dalam format yang salah atau email telah digunakan"));
            break;
          case RegisterState.done:
            Get.toNamed('/home');
            break;
          default:
        }
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    usernameText.value.dispose();
    passText.value.dispose();
    ev.dispose();
    super.onClose();
  }

  void register() async {
    try {
      registerState.value = RegisterState.loading;
      if (usernameText.value.text.isEmpty ||
          emailText.value.text.isEmpty ||
          passText.value.text.isEmpty) {
        registerState.value = RegisterState.emptyText;
        return;
      }
      userData.value = await _service.signUpEmailPass(
          usernameText.value.text.toLowerCase(),
          emailText.value.text,
          passText.value.text);
      if (userData.value != null) {
        registerState.value = RegisterState.done;
      } else {
        registerState.value = RegisterState.already;
      }
    } on NetworkError catch (e) {
      registerState.value = RegisterState.error;
    }
  }
}

enum RegisterState { loading, error, emptyText, already, done }
