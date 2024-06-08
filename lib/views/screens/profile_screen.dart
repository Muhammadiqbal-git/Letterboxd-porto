import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/profile_controller.dart';
import 'package:letterboxd_porto_3/controllers/tmdb_services.dart';
import 'package:letterboxd_porto_3/helpers/dimension.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_img_widget.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_review_card.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 0,
          width: getWidth(context, 100),
          height: getHeight(context, 15) + 40,
          child: Image.asset(
            "assets/imgs/onboarding.png",
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        Positioned(
          top: getHeight(context, 15),
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: context.colors.whiteCr),
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    controller.imgPicker();
                  },
                  child: Obx(() {
                    return CustomImgNetwork(
                        radius: BorderRadius.circular(50),
                        path: controller.user.value!.photo_path);
                  }),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 17,),
                    Text(
                      controller.user.value?.uName ?? "No Name",
                      style: boldText.copyWith(fontSize: 16),
                    ),
                    SizedBox(width: 4,),
                    Image.asset(
                      "assets/icons/edit.png",
                      width: 15,
                    )
                  ],
                );
              }),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() {
                            if (controller.user.value != null) {
                              return Text(
                                "${controller.user.value!.follower.length} Followers",
                                style: normalText.copyWith(fontSize: 12),
                              );
                            }
                            return Text(
                              "0 Followers",
                              style: normalText.copyWith(fontSize: 12),
                            );
                          }),
                          Container(
                            height: 2,
                            width: 60,
                            color: context.colors.secondaryCr,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(() {
                            if (controller.user.value != null) {
                              return Text(
                                "${controller.user.value!.following.length} Following",
                                style: normalText.copyWith(fontSize: 12),
                              );
                            }
                            return Text(
                              "0 Following",
                              style: normalText.copyWith(fontSize: 12),
                            );
                          }),
                          Container(
                            height: 2,
                            width: 60,
                            color: context.colors.secondaryCr,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Obx(() {
                        return Text(
                          "${controller.user.value?.recentMovie?.length ?? "0"}",
                          style: boldText.copyWith(
                              fontSize: 20, color: context.colors.secondaryCr),
                        );
                      }),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        "Total Films",
                        style: normalText,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Obx(() {
                        return Text(
                          "${controller.user.value?.recentMovie?.length ?? "0"}",
                          style: boldText.copyWith(
                              fontSize: 20, color: context.colors.accentCr),
                        );
                      }),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        "Film This Year",
                        style: normalText,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Text(
                        "0",
                        style: boldText.copyWith(
                            fontSize: 20, color: context.colors.secondaryCr),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        "List",
                        style: normalText,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Obx(() {
                        return Text(
                          "${controller.user.value?.recentMovie?.length ?? "0"}",
                          style: boldText.copyWith(
                              fontSize: 20, color: context.colors.accentCr),
                        );
                      }),
                      const SizedBox(
                        height: 3,
                      ),
                      const Text(
                        "Review",
                        style: normalText,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "${controller.user.value?.uName ?? ""}'s Favorite Films",
                style: semiBoldText,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 90,
                child: Obx(() {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.favoriteLength.value,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Container(
                      width: 60,
                      margin: EdgeInsets.only(right: index == 3 ? 0 : 10),
                      child: CustomImgNetwork(
                          path: TMDBServices().imgUrl(
                              width: 154,
                              pathUrl: controller.user.value?.favorite.values
                                      .elementAtOrNull(index) ??
                                  "")),
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                height: 2,
                color: context.colors.whiteCr.withOpacity(0.3),
              ),
              Expanded(child: recentSection(context))
            ],
          ),
        ),
      ],
    );
  }

  Widget recentSection(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(23),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return Text(
                  "${controller.user.value?.uName ?? "Name"}'s Recent Watched",
                  style: semiBoldText.copyWith(fontSize: 12),
                );
              }),
              Text(
                "See All",
                style: semiBoldText.copyWith(
                    fontSize: 10, color: context.colors.secondaryCr),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Obx(() {
            if (controller.recentState.value == RecentMovieState.loading &&
                controller.user.value == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.recentState.value == RecentMovieState.error) {
              return const Text(
                "No recent movie",
                style: semiBoldText,
              );
            } else {
              return SizedBox(
                height: 120,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.user.value!.recentMovie!.length,
                  itemBuilder: (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        width: 60,
                        margin: EdgeInsets.only(right: index == 4 ? 0 : 10),
                        child: CustomImgNetwork(
                          path: TMDBServices().imgUrl(
                              width: 154,
                              pathUrl: controller.user.value!
                                      .recentMovie![index].posterPath ??
                                  ""),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: List.generate(
                            controller.user.value!.recentMovie![index].rate
                                .toInt(),
                            (index) => const Icon(Icons.star,
                                size: 10, color: Colors.red)),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            "Read Review",
                            style: semiBoldText.copyWith(
                                fontSize: 8, color: context.colors.accentCr),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 8,
                            color: context.colors.accentCr,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          }),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() {
                return Text(
                  "${controller.user.value?.uName ?? "Name"}'s Recent Reviews",
                  style: semiBoldText.copyWith(fontSize: 12),
                );
              }),
              Text(
                "See All",
                style: semiBoldText.copyWith(
                    fontSize: 10, color: context.colors.secondaryCr),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Obx(() {
            if (controller.user.value == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.user.value!.recentRev == null ||
                controller.user.value!.recentRev!.isEmpty) {
              return const Text(
                "No review yet",
                style: semiBoldText,
              );
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.user.value!.recentRev!.length,
                itemBuilder: (context, index) => CustomReviewCard(
                  reviewData: controller.user.value!.recentRev![index],
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
