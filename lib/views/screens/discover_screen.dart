import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/discover_controller.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_chip.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_form.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_select_container.dart';
import 'package:letterboxd_porto_3/views/widgets/option_dialog.dart';

class DiscoverScreen extends GetView<DiscoverController> {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("discover built");
    print(controller.listGenre.value?.genreData.first.name);
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
          child: DefaultTabController(
            animationDuration: const Duration(milliseconds: 200),
            length: 2,
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
                      tabs: [
                        const Tab(
                          text: "Film",
                        ),
                        const Tab(
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
                    textEditingController: TextEditingController(),
                    endLogo: Image.asset("assets/icons/notif.png"),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.dialog(OptionDialog());
                                  },
                                  child: Container(
                                    width: 97,
                                    height: 32,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: context.colors.secondaryAccentCr,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Option",
                                          style: normalText.copyWith(
                                              fontSize: 12,
                                              color:
                                                  context.colors.secondaryCr),
                                        ),
                                        ImageIcon(
                                          const AssetImage(
                                              "assets/icons/notif.png"),
                                          size: 20,
                                          color: context.colors.secondaryCr,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const CustomSelectContainer(
                                  selected: true,
                                  text: "Popular",
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                ),
                                const CustomChip(
                                  text: "Adventure",
                                  iconAsset:
                                      AssetImage("assets/icons/notif.png"),
                                  // textStyle: normalText.copyWith(
                                  //     fontSize: 10, color: context.colors.secondaryCr),
                                  // bgColor: Colors.transparent,
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                ),
                                const CustomChip(
                                  text: "Animation",
                                  iconAsset:
                                      AssetImage("assets/icons/notif.png"),
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              height: 82,
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: context.colors.secondaryCr
                                    .withOpacity(0.05),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 60,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(7),
                                        bottomLeft: Radius.circular(7),
                                      ),
                                      child: Image.asset(
                                        "assets/imgs/poster1.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 3, 0, 9),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Title Film",
                                                style: semiBoldText.copyWith(
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Animation. ",
                                                style: semiBoldText.copyWith(
                                                    fontSize: 8,
                                                    color: context
                                                        .colors.secondaryCr),
                                              ),
                                              Text(
                                                "Family. ",
                                                style: semiBoldText.copyWith(
                                                    fontSize: 8,
                                                    color: context
                                                        .colors.secondaryCr),
                                              ),
                                              Text(
                                                "Adventure. ",
                                                style: semiBoldText.copyWith(
                                                    fontSize: 8,
                                                    color: context
                                                        .colors.secondaryCr),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "100k",
                                                style: semiBoldText.copyWith(
                                                    fontSize: 8,
                                                    color: context
                                                        .colors.accentCr),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Text(
                                            "Directed By Someone",
                                            style: normalText.copyWith(
                                                fontSize: 8),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        size: 36,
                                        color: Colors.red,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "4.4",
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
                            )
                          ],
                        ),
                        Container(
                          height: 200,
                          width: 150,
                          color: context.colors.secondaryCr,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
