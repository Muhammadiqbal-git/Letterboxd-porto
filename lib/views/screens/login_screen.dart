import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/login_controller.dart';
import 'package:letterboxd_porto_3/helpers/dimension.dart';
import 'package:letterboxd_porto_3/helpers/diagonal_clipper.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_button.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_form.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primaryCr,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 200),
            top: 0 - (MediaQuery.of(context).viewInsets.bottom/2),
            height: getHeight(context, 38) + 20,
            width: getWidth(context, 100),
            child: ClipPath(
                clipper: DiagonalClipper(),
                child: Image.asset(
                  "assets/imgs/banner.png",
                  fit: BoxFit.cover,
                  alignment: Alignment.topLeft,
                )),
          ),
          AnimatedPositioned(
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 200),
              top: getHeight(context, 28) -
                  (MediaQuery.of(context).viewInsets.bottom / 2),
              right: 40,
              left: 40,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SvgPicture.asset("assets/imgs/logo.svg"),
                    SizedBox(
                      height: getHeight(context, 5),
                    ),
                    Text(
                      "Login",
                      style: boldText.copyWith(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    const Text(
                      "Please sign in to continue",
                      style: normalText,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // CustomForm(textEditingController: textEditingController)
                    Obx(
                      () => CustomForm(
                        hintText: "Email",
                        hintStyle: normalText.copyWith(
                          color: context.colors.whiteCr.withOpacity(0.5),
                        ),
                        logo: const AssetImage(
                          "assets/icons/person.png",
                        ),
                        textEditingController: controller.usernameText.value,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => CustomForm(
                        hintText: "Password",
                        hintStyle: normalText.copyWith(
                          color: context.colors.whiteCr.withOpacity(0.5),
                        ),
                        isObsecure: true,
                        logo: const AssetImage(
                          "assets/icons/pass.png",
                        ),
                        textEditingController: controller.passText.value,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        overlayColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        child: Text(
                          "Forgot Password?",
                          style: normalText.copyWith(
                              fontSize: 12, color: context.colors.secondaryCr),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      onTap: () {
                        controller.login();
                      },
                      width: 80 + getWidth(context, 10),
                      child: Text(
                        "Login",
                        style:
                            boldText.copyWith(color: context.colors.primaryCr),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? Please ",
                          style: normalText.copyWith(
                              fontSize: 12, color: context.colors.secondaryCr),
                        ),
                        InkWell(
                            onTap: () {
                              Get.offNamed('/register');
                            },
                            overlayColor:
                                const MaterialStatePropertyAll(Colors.transparent),
                            child: Text(
                              "Sign Up ",
                              style: normalText.copyWith(
                                  fontSize: 12, color: context.colors.accentCr),
                            )),
                        Text(
                          "first",
                          style: normalText.copyWith(
                              fontSize: 12, color: context.colors.secondaryCr),
                        ),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
