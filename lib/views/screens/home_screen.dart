import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:letterboxd_porto_3/controllers/home_controller.dart';
import 'package:letterboxd_porto_3/controllers/tmdb_services.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_img_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/custom_review_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({
    super.key,
  });

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
                          Scaffold.of(context).openDrawer();
                        },
                        child: ImageIcon(
                          AssetImage("assets/icons/burger.png"),
                          color: context.colors.whiteCr,
                        )),
                    CircleAvatar(
                      backgroundColor: context.colors.whiteCr,
                    )
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
                    Text(
                      "Name",
                      style: boldText.copyWith(
                          fontSize: 18, color: context.colors.secondaryCr),
                    ),
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
                    height: 90,
                    child: Obx(() {
                      print(HomeController.loading);
                      if (HomeController.loading.value) {
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
                            width: 58,
                            height: 82,
                            margin: const EdgeInsets.only(right: 10),
                            child: InkWell(
                              onTap: () => Get.toNamed('/film_detail'),
                              child: CustomImgNetwork(
                                path: TMDBServices().imgUrl(
                                  pathUrl: controller
                                      .data.value!.results[index].posterPath,
                                ),
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
                  "Popular List This Month",
                  style: boldText,
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) => Container(
                      width: 50,
                      height: 50,
                      margin: const EdgeInsets.only(right: 10),
                      color: context.colors.whiteCr,
                    ),
                  ),
                ),
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
                    child: ListView.builder(
                        itemBuilder: (context, index) =>
                            const CustomReviewCard()))
              ],
            ),
          );
  }
}
