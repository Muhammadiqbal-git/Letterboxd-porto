import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/helpers/dimension.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primaryCr,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            width: getWidth(context, 100),
            height: getHeight(context, 48),
            child: ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                        begin: Alignment(0, 0.85),
                        end: Alignment(0, 1),
                        colors: [Colors.black, Colors.transparent])
                    .createShader(
                        Rect.fromLTRB(0, 0, bounds.width, bounds.height));
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                "assets/imgs/onboarding.png",
                fit: BoxFit.cover,
                alignment: Alignment.topLeft,
              ),
            ),
          ),
          Positioned(
            top: getHeight(context, 43),
            right: 40,
            left: 40,
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/imgs/logo.svg",
                  width: getWidth(context, 38),
                ),
                SizedBox(
                  height: getHeight(context, 8),
                ),
                Text(
                  "\"Track films you’ve watched. Save those you want to see. Tell your friends what’s good.\"",
                  style: semiBoldText.copyWith(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getHeight(context, 10),
                ),
                CustomButton(
                  onTap: () {
                    Get.offAndToNamed('/login');
                  },
                  width: 100 + getWidth(context, 10),
                    child: Text(
                  "Get Started",
                  style: boldText.copyWith(color: context.colors.primaryCr),
                ),)
              ],
            ),
          )
          // Positioned(
          //   bottom: 0,
          //   width: getWidth(context, 100),
          //   height: getHeight(context, 50),
          //   child: Container(
          //     decoration: BoxDecoration(
          //       gradient: LinearGradient(
          //         begin: Alignment(0, -0.4),
          //         end: Alignment(0, -1),
          //         colors: [context.colors.primaryCr, context.colors.primaryCr.withOpacity(0.5), Colors.transparent])
          //     ),
          //   ))
        ],
      ),
    );
  }
}
