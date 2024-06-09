import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:letterboxd_porto_3/controllers/movie_detail_controller.dart';
import 'package:letterboxd_porto_3/controllers/tmdb_services.dart';
import 'package:letterboxd_porto_3/helpers/dimension.dart';
import 'package:letterboxd_porto_3/helpers/diagonal_clipper.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_button.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_img_widget.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_review_card.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MovieDetailScreen extends GetView<MovieController> {
  const MovieDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    print(controller.state.value);
    return Scaffold(
      backgroundColor: context.colors.primaryCr,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            height: getHeight(context, 30),
            width: getWidth(context, 100),
            child: ClipPath(
              clipper: DiagonalClipper(),
              child: Obx(() {
                if (controller.state.value == MovieState.done) {
                  return CustomImgNetwork(
                      path: TMDBServices().imgUrl(
                          width: 1280,
                          pathUrl:
                              controller.detailData.value?.backdropPath ?? ""));
                }
                return Image.asset(
                  "assets/imgs/banner.png",
                  fit: BoxFit.cover,
                );
              }),
            ),
          ),
          Positioned(
            top: getHeight(context, 30) - 80,
            left: 20,
            right: 20,
            bottom: 0,
            child: Column(
              children: [
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //left Section (Image)
                    _LeftSection(),
                    SizedBox(
                      width: 20,
                    ),
                    // Righ Section (Title)
                    _RightSection()
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return Skeletonizer(
                    enabled: controller.state.value == MovieState.loading,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 20,
                              width: 45,
                              margin: const EdgeInsets.only(bottom: 4),
                              decoration: BoxDecoration(
                                color: context.colors.accentCr,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Casts",
                                style: semiBoldText.copyWith(fontSize: 10),
                              ),
                            ),
                            Skeleton.ignore(
                              child: Container(
                                height: 2,
                                width: 30,
                                color: context.colors.accentCr,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 20,
                          width: 45,
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: context.colors.primaryCr,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Crews",
                            style: semiBoldText.copyWith(fontSize: 10),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 20,
                          width: 45,
                          margin: const EdgeInsets.only(bottom: 4),
                          decoration: BoxDecoration(
                            color: context.colors.primaryCr,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Details",
                            style: semiBoldText.copyWith(fontSize: 10),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                Obx(() {
                  if (controller.state.value == MovieState.done) {
                    return Container(
                      height: 45,
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.castData.length >= 5
                            ? 5
                            : controller.castData.length,
                        itemBuilder: (context, index) => Container(
                          height: 45,
                          width: 45,
                          margin: EdgeInsets.only(right: index == 4 ? 0 : 10),
                          child: CustomImgNetwork(
                            align: const Alignment(0, -0.4),
                            radius: BorderRadius.circular(50),
                            path: TMDBServices().imgUrl(
                                width: 185,
                                pathUrl: controller
                                        .castData[index].profilePath ??
                                    ""),
                          ),
                        ),
                      ),
                    );
                  }
                  return Container(
                    height: 45,
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) => Container(
                        height: 45,
                        width: 45,
                        margin: EdgeInsets.only(right: index == 4 ? 0 : 10),
                        decoration: BoxDecoration(
                            color: context.colors.secondaryCr,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Reviews",
                      style: semiBoldText.copyWith(fontSize: 12),
                    ),
                    Text(
                      "See All",
                      style: semiBoldText.copyWith(
                          fontSize: 10, color: context.colors.secondaryCr),
                    ),
                  ],
                ),
                Container(
                  height: 2,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(top: 3),
                  color: context.colors.whiteCr.withOpacity(0.3),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: Obx(() {
                    if (controller.reviewData.value != null &&
                        controller.state.value == MovieState.done) {
                      if (controller.reviewData.value!.reviewData.isEmpty) {
                        return const Text(
                          "No review yet",
                          style: semiBoldText,
                        );
                      }
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount:
                            controller.reviewData.value!.reviewData.length,
                        itemBuilder: (context, index) => CustomReviewCard(
                          reviewData:
                              controller.reviewData.value!.reviewData[index],
                          withImage: false,
                          
                        ),
                      );
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 2,
                      itemBuilder: (context, index) => CustomReviewCard(
                        reviewData: null,
                        loading: controller.state.value == MovieState.loading,
                        withImage: false,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          // BACK BUTTON
          Positioned(
            top: 5,
            left: 20,
            child: SafeArea(
              child: Material(
                borderRadius: BorderRadius.circular(50),
                color: context.colors.primaryCr,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () => Get.back(),
                  child: Ink(
                    height: 30,
                    width: 30,
                    child: Icon(
                      Icons.arrow_back,
                      color: context.colors.whiteCr,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RightSection extends GetView<MovieController> {
  const _RightSection();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        return Skeletonizer(
          enabled: controller.state.value == MovieState.loading,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() {
                if (controller.state.value == MovieState.done) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Flexible(
                                child: CustomText(
                              controller.detailData.value!.title,
                              style: boldText.copyWith(fontSize: 18),
                            )),
                            Text(
                              DateFormat("yyyy").format(
                                  controller.detailData.value!.releaseDate),
                              style: normalText.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Skeleton.ignore(
                        child: Text(
                          "${controller.detailData.value!.runtime} mins",
                          style: normalText.copyWith(fontSize: 11),
                        ),
                      )
                    ],
                  );
                } else {
                  return Row(
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
                      const Spacer(),
                      Skeleton.ignore(
                        child: Text(
                          "172 mins",
                          style: normalText.copyWith(fontSize: 11),
                        ),
                      )
                    ],
                  );
                }
              }),
              Obx(() {
                if (controller.state.value == MovieState.done) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text("Directed by ",
                          style: normalText.copyWith(fontSize: 12)),
                      Text(controller.director.value,
                          style: semiBoldText.copyWith(fontSize: 12))
                    ],
                  );
                }
                return const Text(
                  "Directed by Someone",
                );
              }),
              const SizedBox(
                height: 10,
              ),
              Obx(() {
                if (controller.state.value == MovieState.done) {
                  return Text(
                    controller.detailData.value!.overview,
                    style: normalText.copyWith(fontSize: 10),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                  );
                }
                return Text(
                  "UNMASK THE TRUTH \n\nIn his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.",
                  style: normalText.copyWith(fontSize: 10),
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                );
              }),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Spacer(),
                  Column(
                    children: [
                      Text(
                        "Ratings",
                        style: normalText.copyWith(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Obx(() {
                        if (controller.state.value == MovieState.done) {
                          return Column(
                            children: [
                              Text(
                                (controller.detailData.value!.voteAverage / 2)
                                    .toStringAsFixed(1),
                                style: semiBoldText.copyWith(
                                    fontSize: 30,
                                    color: context.colors.secondaryCr),
                              ),
                              Skeleton.unite(
                                child: Row(
                                  children: List.generate(
                                    int.parse((controller
                                                .detailData.value!.voteAverage /
                                            2)
                                        .toStringAsFixed(0)),
                                    (index) => const Icon(
                                      Icons.star,
                                      size: 10,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return Column(
                          children: [
                            Text(
                              "4.4",
                              style: semiBoldText.copyWith(
                                  fontSize: 30,
                                  color: context.colors.secondaryCr),
                            ),
                            Skeleton.unite(
                              child: Row(
                                children: List.generate(
                                  5,
                                  (index) => const Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      }),
    );
  }
}

class _LeftSection extends GetView<MovieController> {
  const _LeftSection();

  @override
  Widget build(BuildContext context) {
    print('left built');
    return Obx(() {
      print('obx built');
      return Skeletonizer(
        enabled: controller.state.value == MovieState.loading,
        child: Column(
          children: [
            Container(
              width: 110,
              height: 170,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: context.colors.primaryCr,
                      blurRadius: 4,
                      spreadRadius: 4),
                ],
              ),
              child: Obx(() {
                if (controller.state.value == MovieState.done) {
                  return CustomImgNetwork(
                    path: TMDBServices().imgUrl(
                        pathUrl: controller.detailData.value!.posterPath,
                        width: 500),
                  );
                } else {
                  return Skeleton.leaf(
                    child: Container(
                      decoration: BoxDecoration(
                        color: context.colors.whiteCr,
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                  );
                }
              }),
            ),
            const SizedBox(
              height: 5,
            ),
            Skeleton.unite(
              child: Row(
                children: [
                  Column(
                    children: [
                      const ImageIcon(
                        AssetImage("assets/icons/view.png"),
                        size: 14,
                        color: Colors.green,
                      ),
                      Obx( () {
                        if (controller.state.value == MovieState.done) {
                          return Text(
                            controller.detailData.value!.popularity,
                            style: normalText.copyWith(fontSize: 8),
                          );
                        }
                          return Text(
                            "40k",
                            style: normalText.copyWith(fontSize: 8),
                          );
                        }
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      const ImageIcon(
                        AssetImage("assets/icons/liked.png"),
                        color: Colors.red,
                        size: 14,
                      ),
                      Text(
                        "0",
                        style: normalText.copyWith(fontSize: 8),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      const ImageIcon(
                        AssetImage("assets/icons/comment.png"),
                        color: Colors.blue,
                        size: 14,
                      ),
                      Text(
                        "0",
                        style: normalText.copyWith(fontSize: 8),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Skeleton.unite(
              child: Column(
                children: [
                  CustomButton(
                    width: 105,
                    height: 25,
                    padding: const EdgeInsets.all(5),
                    child: InkWell(
                      onTap: () => Get.toNamed('/add_review'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            const AssetImage("assets/icons/review.png"),
                            color: context.colors.primaryCr,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Rate or Review",
                            style: boldText.copyWith(
                                fontSize: 8, color: context.colors.primaryCr),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomButton(
                    width: 105,
                    height: 25,
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(
                          const AssetImage("assets/icons/list.png"),
                          color: context.colors.primaryCr,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Add to List",
                          style: boldText.copyWith(
                              fontSize: 8, color: context.colors.primaryCr),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomButton(
                    width: 105,
                    height: 25,
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(
                          const AssetImage("assets/icons/watchlist.png"),
                          color: context.colors.primaryCr,
                          size: 14,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Add to Watchlist",
                          style: boldText.copyWith(
                              fontSize: 8, color: context.colors.primaryCr),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
