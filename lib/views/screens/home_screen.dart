import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/home_controller.dart';
import 'package:letterboxd_porto_3/controllers/main_screen_controller.dart';
import 'package:letterboxd_porto_3/controllers/profile_controller.dart';
import 'package:letterboxd_porto_3/controllers/tmdb_services.dart';
import 'package:letterboxd_porto_3/helpers/dimension.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_img_widget.dart';

import '../widgets/custom_review_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({
    super.key,
  });
  ProfileController get _profileController => Get.find();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Scaffold.of(context).openDrawer();
                  },
                  child: ImageIcon(
                    const AssetImage("assets/icons/burger.png"),
                    color: context.colors.whiteCr,
                  )),
              Obx(() {
                if (_profileController.state.value == ProfileState.done) {
                  return InkWell(
                    onTap: () {
                      Get.find<MainScreenController>().changeIndex(3);
                    },
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CustomImgNetwork(
                          radius: BorderRadius.circular(50),
                          path:
                              _profileController.user?.photoPath ?? ""),
                    ),
                  );
                }
                return CircleAvatar(
                  backgroundColor: context.colors.whiteCr,
                );
              })
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "Hello ",
                style: boldText.copyWith(
                    fontSize: 18, color: context.colors.whiteCr),
              ),
              Obx(() {
                return Text(
                  (_profileController.user?.uName) ?? "name",
                  style: boldText.copyWith(
                      fontSize: 18, color: context.colors.secondaryCr),
                );
              }),
              Text(
                "!",
                style: boldText.copyWith(
                    fontSize: 18, color: context.colors.whiteCr),
              ),
            ],
          ),
          Text(
            "Review or track film you’ve watched...",
            style: normalText.copyWith(
                fontSize: 12, color: context.colors.whiteCr),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Popular Films This Month",
            style: boldText,
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
              height: 90 + getWidth(context, 5),
              child: Obx(() {
                if (controller.loading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: context.colors.secondaryCr,
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.data.value!.results.length,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (context, index) => Container(
                      width: 58 + getWidth(context, 5),
                      height: 82 + getWidth(context, 5),
                      margin: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () => Get.toNamed('/movie_detail', arguments: {
                          "id": controller.data.value!.results[index].id
                        }),
                        child: CustomImgNetwork(
                          path: TMDBServices().imgUrl(
                              pathUrl: controller
                                      .data.value!.results[index].posterPath ??
                                  "",
                              width: 500),
                        ),
                      ),
                    ),
                  );
                }
              })),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Most Rated Film in the past 3 Month",
            style: boldText,
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
              height: 90 + getWidth(context, 5),
              child: Obx(() {
                if (controller.loading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: context.colors.secondaryCr,
                    ),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.ratedData.value!.results.length,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (context, index) => Container(
                      width: 58 + getWidth(context, 5),
                      height: 82 + getWidth(context, 5),
                      margin: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () => Get.toNamed('/movie_detail', arguments: {
                          "id": controller.ratedData.value!.results[index].id
                        }),
                        child: CustomImgNetwork(
                          path: TMDBServices().imgUrl(
                              pathUrl: controller.ratedData.value!
                                      .results[index].posterPath ??
                                  "",
                              width: 500),
                        ),
                      ),
                    ),
                  );
                }
              })),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Recent Friends' Review",
            style: boldText,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Obx(() {
              if (controller.reviewData.value != null) {
                return ListView.builder(
                  itemCount: controller.reviewData.value!.reviewData.length,
                  itemBuilder: (context, index) => CustomReviewCard(
                    reviewData: controller.reviewData.value!.reviewData[index],
                  ),
                );
              } else if (controller.loading.value) {
                return Center(
                  child: CircularProgressIndicator(color: context.colors.secondaryCr,),
                );
              } else {
                return const Center(
                  child: Text(
                    "No recent review",
                    style: semiBoldText,
                  ),
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
