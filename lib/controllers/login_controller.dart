import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/firebase_auth_services.dart';
import 'package:letterboxd_porto_3/exceptions/error.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_alert_dialog.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_loading_dialog.dart';

class LoginController extends GetxController {
  final FirebaseAuthService _service = FirebaseAuthService();
  Rx<TextEditingController> usernameText = TextEditingController().obs;
  Rx<TextEditingController> passText = TextEditingController().obs;
  Rx<User?> userData = Rx<User?>(null);
  Rx<bool> loading = false.obs;
  Rx<bool> error = false.obs;
  late Worker ev;

  @override
  void onInit() {
    ev = ever(loading, (callback) {
      if (callback) {
        Get.dialog(
          const CustomLoadingDialog(),
          barrierDismissible: false,
        ).then((value) {
          if (usernameText.value.text.isEmpty || passText.value.text.isEmpty) {
            Get.dialog(const CustomAlertDialog(
                text: "Email atau Password tidak boleh kosong"));
          } else if (error.value) {
            Get.dialog(const CustomAlertDialog(
                text: "Connection Timeout, check lagi internetnya"));
          } else if (userData.value is! User) {
            Get.dialog(const CustomAlertDialog(
                text: "Email atau Password tidak cocok"));
          }
        });
      } else {
        Get.back();
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

  void login() async {
    try {
      error.value = false;
      loading.value = true;
      userData.value = await _service.loginEmailPass(
          usernameText.value.text, passText.value.text);
      loading.value = false;
      if (userData.value != null) {
        Get.toNamed('/home');
      }
    } on NetworkError catch (e) {
      loading.value = false;
      error.value = true;
    }
  }
}
