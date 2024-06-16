import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:letterboxd_porto_3/controllers/discover_film_controller.dart';
import 'package:letterboxd_porto_3/controllers/favorite_controller.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';

import '../../controllers/tmdb_services.dart';
import '../widgets/custom_img_widget.dart';
import '../widgets/custom_text.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.primaryCr,
      appBar: AppBar(
        backgroundColor: context.colors.primaryCr,
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: InkWell(
            radius: 10,
            borderRadius: BorderRadius.circular(50),
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: context.colors.whiteCr,
            ),
          ),
        ),
        title: Text(
          "Favorite",
          style: boldText.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top 4 will be displayed in your profile",
              style: normalText.copyWith(fontSize: 12),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Obx(() {
                print("built");
                if (controller.state.value == ListFavoriteState.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ReorderableListView.builder(
                  buildDefaultDragHandles: false,
                  proxyDecorator: (child, index, animation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (context, child) {
                        return Material(
                          color: Colors.transparent,
                          child: child,
                        );
                      },
                      child: child,
                    );
                  },
                  itemCount: controller.listFav.length,
                  itemBuilder: (context, index) {
                    final data = controller.listFav[index];
                    return Container(
                      key: Key("$index"),
                      height: 60,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: context.colors.secondaryCr.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () {
                          print("tes");
                          // FocusScope.of(context).unfocus();
                          // Get.toNamed('/movie_detail',
                          //     arguments: {"id": data.id});
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 45,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  bottomLeft: Radius.circular(7),
                                ),
                                child: CustomImgNetwork(
                                  key: Key("${data.posterPath}"),
                                  path: TMDBServices().imgUrl(
                                      width: 154,
                                      pathUrl: data.posterPath ?? ""),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 3, 0, 9),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: CustomText(
                                            "${data.title}",
                                            multiLine: false,
                                            style: semiBoldText.copyWith(
                                                fontSize: 12),
                                          ),
                                        ),
                                        Text(
                                          DateFormat("yyyy")
                                              .format(data.releaseDate),
                                          style:
                                              normalText.copyWith(fontSize: 8),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      children: [
                                        ...data.genreName
                                            .take(3)
                                            .map(
                                              (e) => Text(
                                                "$e ",
                                                style: semiBoldText.copyWith(
                                                    fontSize: 8,
                                                    color: context
                                                        .colors.secondaryCr),
                                              ),
                                            )
                                            .toList(),
                                        Text(
                                          controller.getGenreListRemainder(
                                              data.genreName),
                                          style: semiBoldText.copyWith(
                                              fontSize: 8,
                                              color:
                                                  context.colors.secondaryCr),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        Text(
                                          "100",
                                          style: semiBoldText.copyWith(
                                              fontSize: 10,
                                              color: context.colors.accentCr),
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Image.asset(
                                          "assets/icons/view.png",
                                          height: 10,
                                          color: context.colors.accentCr,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${index + 1 <= 4 ? index + 1 : "#"}",
                              style: semiBoldText.copyWith(
                                  fontSize: 18,
                                  color: context.colors.secondaryCr),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ReorderableDragStartListener(
                              index: index,
                              child: Container(
                                width: 45,
                                height: double.maxFinite,
                                decoration: BoxDecoration(
                                  color: context.colors.secondaryAccentCr,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(7),
                                      bottomRight: Radius.circular(7)),
                                ),
                                child: Icon(Icons.drag_handle_rounded, color: context.colors.secondaryCr,),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    controller.changeOrder(oldIndex, newIndex);
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
