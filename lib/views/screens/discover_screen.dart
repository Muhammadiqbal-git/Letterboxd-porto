import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:letterboxd_porto_3/controllers/discover_film_controller.dart';
import 'package:letterboxd_porto_3/controllers/discover_people_controller.dart';
import 'package:letterboxd_porto_3/controllers/profile_controller.dart';
import 'package:letterboxd_porto_3/controllers/tmdb_services.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:letterboxd_porto_3/models/movie_list_model.dart';
import 'package:letterboxd_porto_3/views/screens/profile_screen.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_chip.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_form.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_img_widget.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_select_container.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_text.dart';

class DiscoverScreen extends GetView<DiscoverFilmController> {
  const DiscoverScreen({super.key});
  DiscoverPeopleController get _peopleController =>
      Get.find<DiscoverPeopleController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          alignment: Alignment.center,
          child: Text(
            "Discover",
            style: boldText.copyWith(fontSize: 20),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Container(
                  height: 42,
                  decoration: BoxDecoration(
                      color: context.colors.secondaryAccentCr,
                      borderRadius: BorderRadius.circular(7)),
                  child: TabBar(
                    controller: controller.tabController.value,
                    unselectedLabelColor: context.colors.secondaryCr,
                    labelColor: context.colors.primaryCr,
                    labelPadding: EdgeInsets.zero,
                    labelStyle: semiBoldText.copyWith(fontSize: 13),
                    overlayColor:
                        const MaterialStatePropertyAll(Colors.transparent),
                    unselectedLabelStyle: semiBoldText.copyWith(fontSize: 12),
                    indicator: BoxDecoration(
                        color: context.colors.secondaryCr,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.6))
                        ]),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: Colors.transparent,
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(
                        text: "Film",
                      ),
                      Tab(
                        text: "People",
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                CustomForm(
                  height: 42,
                  hintText: "Search ...",
                  hintStyle: normalText.copyWith(
                      fontSize: 12, color: context.colors.secondaryCr),
                  inputStyle: normalText.copyWith(fontSize: 12),
                  backgroundColor: context.colors.secondaryAccentCr,
                  contentPadding: EdgeInsets.zero,
                  textAlignVertical: TextAlignVertical.center,
                  borderRadius: 7,
                  textInputAction: TextInputAction.done,
                  textEditingController: controller.searchText.value,
                  onChanged: (p0) {
                    if (controller.tabController.value.index == 0) {
                      controller.debounceSearch();
                    } else {
                      _peopleController.debounceSearch();
                    }
                  },
                  endLogo: Image.asset(
                    "assets/icons/discover.png",
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController.value,
                    children: [filmSection(context), peopleSection(context)],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget peopleSection(BuildContext context) {
    return Obx(() {
      if (_peopleController.state.value == DiscoverPeopleState.initial) {
        return Center(
          child: Text(
            "Search for other movie enthusiast!",
            style: semiBoldText.copyWith(
                fontSize: 16, color: context.colors.secondaryCr),
            textAlign: TextAlign.center,
          ),
        );
      } else if (_peopleController.state.value == DiscoverPeopleState.loading) {
        return Center(
            child: CircularProgressIndicator(
          color: context.colors.secondaryCr,
        ));
      } else if (_peopleController.state.value == DiscoverPeopleState.empty) {
        return Center(
          child: Text(
            "There no individual with that name",
            style: semiBoldText.copyWith(
                fontSize: 16, color: context.colors.secondaryCr),
            textAlign: TextAlign.center,
          ),
        );
      } else if (_peopleController.state.value == DiscoverPeopleState.done) {
        return ListView.builder(
            itemCount: _peopleController.listPeople.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(7),
                  onTap: () {
                    if (FocusScope.of(context).hasFocus &&
                        !FocusScope.of(context).hasPrimaryFocus) {
                      // FocusScope.of(context).unfocus();
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                    Get.find<ProfileController>().readOtherProfile(
                        _peopleController.listPeople[index].uId);
                    Get.to(
                      () => Scaffold(
                        backgroundColor: context.colors.primaryCr,
                        body: const SafeArea(
                          child: ProfileScreen(
                            isOther: true,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 60,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: context.colors.secondaryCr.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 45,
                          height: 45,
                          child: CustomImgNetwork(
                              radius: BorderRadius.circular(50),
                              path: _peopleController
                                  .listPeople[index].photoPath),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _peopleController.listPeople[index].uName,
                                style: normalText.copyWith(fontSize: 12),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "${_peopleController.listPeople[index].reviewRef.length} Review written",
                                style: normalText.copyWith(
                                    fontSize: 10,
                                    color: context.colors.whiteCr
                                        .withOpacity(0.8)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      } else {
        return Center(
          child: Text(
            "Error happen",
            style: semiBoldText.copyWith(
                fontSize: 16, color: context.colors.secondaryCr),
            textAlign: TextAlign.center,
          ),
        );
      }
    });
  }

  Widget filmSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                FocusScope.of(context).unfocus();
                controller.openOptionDialog();
              },
              child: Container(
                width: 97,
                height: 32,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: context.colors.secondaryAccentCr,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Option",
                      style: normalText.copyWith(
                          fontSize: 12, color: context.colors.secondaryCr),
                    ),
                    Image.asset(
                      "assets/icons/filter.png",
                      height: 18,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Flexible(
              child: Obx(() {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Row(
                    children: [
                      if (controller.selectedSort.value != null)
                        CustomSelectContainer(
                          key: Key(controller.selectedSort.value?.name ?? ""),
                          selected: controller
                              .checkSort(controller.selectedSort.value!),
                          text: controller.selectedSort.value!.name,
                          onTap: (selected) {
                            controller.clearSort();
                            controller.debounceSearchByGenre();
                          },
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                        ),
                      if (controller.selectedGenre.isNotEmpty)
                        ...controller.selectedGenre
                            .map(
                              (e) => CustomChip(
                                text: e.name,
                                onTap: () {
                                  controller.removeGenre(e);
                                  controller.debounceSearchByGenre();
                                },
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                iconAsset:
                                    const AssetImage("assets/icons/x_mark.png"),
                              ),
                            )
                            .toList()
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        Expanded(
          child: Obx(() {
            if (controller.state.value == DiscoverState.done) {
              return Material(
                color: context.colors.primaryCr,
                child: ListView.builder(
                  itemCount: controller.resultMovie.value!.results.length,
                  itemBuilder: (context, index) {
                    Result data = controller.resultMovie.value!.results[index];
                    return Container(
                      height: 82,
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: context.colors.secondaryCr.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(7),
                        onTap: () {
                          if (FocusScope.of(context).hasFocus &&
                              !FocusScope.of(context).hasPrimaryFocus) {
                            FocusScope.of(context).unfocus();
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                          print(data.id);
                          Get.toNamed('/movie_detail',
                              arguments: {"id": data.id});
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(7),
                                  bottomLeft: Radius.circular(7),
                                ),
                                child: CustomImgNetwork(
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
                                            data.title,
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
                                        ...data.genreIds
                                            .take(3)
                                            .map(
                                              (e) => Text(
                                                "${controller.getGenreName(e)}. ",
                                                style: semiBoldText.copyWith(
                                                    fontSize: 8,
                                                    color: context
                                                        .colors.secondaryCr),
                                              ),
                                            )
                                            .toList(),
                                        Text(
                                          controller.getGenreListRemainder(
                                              data.genreIds),
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
                                          data.popularity.toString(),
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
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  size: 36,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  (data.voteAverage / 2).toStringAsFixed(1),
                                  style: normalText.copyWith(
                                      fontSize: 20,
                                      color: context.colors.secondaryCr),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (controller.state.value == DiscoverState.initial) {
              return Center(
                child: Text(
                  "Discover some film!",
                  style: semiBoldText.copyWith(
                      fontSize: 16, color: context.colors.secondaryCr),
                  textAlign: TextAlign.center,
                ),
              );
            } else if (controller.state.value == DiscoverState.empty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No specific film in our database",
                      style: semiBoldText.copyWith(
                          fontSize: 16, color: context.colors.secondaryCr),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Maybe its too much filter and keyword in the same time?",
                      style: normalText.copyWith(
                          fontSize: 14, color: context.colors.secondaryCr),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: context.colors.secondaryCr,
                ),
              );
            }
          }),
        )
      ],
    );
  }
}
