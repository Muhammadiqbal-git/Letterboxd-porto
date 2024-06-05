import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:letterboxd_porto_3/controllers/movie_detail_controller.dart';
import 'package:letterboxd_porto_3/controllers/review_controller.dart';
import 'package:letterboxd_porto_3/controllers/tmdb_services.dart';
import 'package:letterboxd_porto_3/helpers/dimension.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_button.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_form.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_img_widget.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_text.dart';

class ReviewScreen extends GetView<ReviewController> {
  const ReviewScreen({super.key});
  MovieController get movieController => Get.find<MovieController>();

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
                      Obx(() {
                        if (movieController.state.value == MovieState.done) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Flexible(
                                child: CustomText(
                                  movieController.detailData.value!.title,
                                  multiLine: false,
                                  style: boldText.copyWith(fontSize: 20),
                                ),
                              ),
                              Text(
                                DateFormat("yyyy").format(movieController
                                    .detailData.value!.releaseDate),
                                style: normalText.copyWith(fontSize: 12),
                              ),
                            ],
                          );
                        } else {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "Film Name",
                                style: boldText.copyWith(fontSize: 20),
                              ),
                              Text(
                                "2022",
                                style: normalText.copyWith(fontSize: 12),
                              ),
                            ],
                          );
                        }
                      }),
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
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: Color(0xffC4C4C4).withOpacity(0.35),
                          ),
                          child: Text(
                            DateFormat("yyyy-MM-dd")
                                .format(controller.selectedDate.value),
                            style: semiBoldText.copyWith(fontSize: 12),
                          ),
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
                Obx(() {
                  return Container(
                    width: 110 + getWidth(context, 2),
                    height: 170 + getWidth(context, 2),
                    child: CustomImgNetwork(
                        path: TMDBServices().imgUrl(
                            pathUrl:
                                movieController.detailData.value?.posterPath ??
                                    "")),
                  );
                }),
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
                  textEditingController: controller.reviewText.value),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                  onTap: () {
                    if (movieController.state.value == MovieState.done) {
                      controller.addReview();
                      // controller.getAllReview(filmId: 1022789);
                    }
                  },
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
