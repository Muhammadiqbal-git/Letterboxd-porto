import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/review_controller.dart';
import 'package:letterboxd_porto_3/dimension.dart';
import 'package:letterboxd_porto_3/style.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_button.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_form.dart';

class ReviewScreen extends GetView<ReviewController> {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primaryCr,
      appBar: AppBar(
        backgroundColor: context.colors.primaryCr,
        leading: InkWell(
            onTap: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: context.colors.whiteCr,
            )),
        title: Text(
          "Write Your Review",
          style: semiBoldText.copyWith(fontSize: 14),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            "The Batman ",
                            style: boldText.copyWith(fontSize: 20),
                          ),
                          Text(
                            "2022",
                            style: normalText.copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Specify the date you watched it",
                        style: normalText.copyWith(fontSize: 10),
                      ),
                      const SizedBox(height: 5),
                      InkWell(
                        onTap: () => controller.datePicker(context),
                        child: Container(
                          height: 28,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Color(0xffC4C4C4).withOpacity(0.35)),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Give your rating",
                        style: normalText.copyWith(fontSize: 10),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: List.generate(
                            5,
                            (index) => Icon(
                                  Icons.star,
                                  size: 22,
                                  color:
                                      context.colors.whiteCr.withOpacity(0.3),
                                )),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 45,
                ),
                Container(
                  width: 110 + getWidth(context, 2),
                  height: 170 + getWidth(context, 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      image: DecorationImage(
                        image: AssetImage("assets/imgs/poster1.png"),
                        fit: BoxFit.cover,
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: CustomForm(
                  contentPadding: EdgeInsets.all(16),
                  inputStyle: normalText.copyWith(fontSize: 12),
                  hintText: "Write down your review ...",
                  hintStyle: normalText.copyWith(
                      fontSize: 12,
                      color: context.colors.whiteCr.withOpacity(0.5)),
                  textAlignVertical: TextAlignVertical.top,
                  height: double.maxFinite,
                  textEditingController: TextEditingController()),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                  width: 80,
                  child: Text(
                    "Publish",
                    style:
                        semiBoldText.copyWith(color: context.colors.primaryCr),
                  )),
            )
          ],
        ),
      ),
    );
  }


}
