import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/controllers/discover_film_controller.dart';
import 'package:letterboxd_porto_3/helpers/dimension.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_select_container.dart';

class OptionDialog extends StatelessWidget {
  const OptionDialog({super.key});

  DiscoverFilmController get _discoverController => Get.find<DiscoverFilmController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.colors.secondaryAccentCr,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      title: Row(
        children: [
          const Spacer(),
          Text(
            "Option",
            style: boldText.copyWith(
                fontSize: 14, color: context.colors.secondaryCr),
          ),
          const Spacer(),
          ImageIcon(
            const AssetImage("assets/icons/notif.png"),
            size: 24,
            color: context.colors.secondaryCr,
          ),
        ],
      ),
      titlePadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 2,
            color: context.colors.secondaryCr,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            "Sort",
            style: semiBoldText.copyWith(
                fontSize: 12, color: context.colors.secondaryCr),
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(() {
              return Wrap(
                direction: Axis.horizontal,
                spacing: 13,
                runSpacing: 6,
                children: [
                  ..._discoverController.listSort
                      .map((e) => CustomSelectContainer(
                            text: e.name,
                            selected: _discoverController.checkSort(e),
                            onTap: (selected) {
                              _discoverController.selectSort(e);
                            },
                            style: normalText.copyWith(
                                fontSize: 10, color: context.colors.secondaryCr),
                          ))
                      .toList()
                ],
              );
            }
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Genre",
                style: semiBoldText.copyWith(
                    fontSize: 12, color: context.colors.secondaryCr),
              ),
              const SizedBox(
                width: 7,
              ),
              Obx(() {
                if (_discoverController.selectedGenre.isNotEmpty) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "${_discoverController.selectedGenre.length} picked",
                        style: normalText.copyWith(
                            fontSize: 8, color: context.colors.secondaryCr),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      InkWell(
                        onTap: () {
                          _discoverController.clearGenre();
                        },
                        child: Image.asset("assets/icons/notif.png",
                            color: context.colors.accentCr, height: 12),
                      )
                    ],
                  );
                } else {

                  return const SizedBox.shrink();
                }
              })
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Obx(() {
            return Wrap(
              direction: Axis.horizontal,
              spacing: 13,
              runSpacing: 6,
              children: [
                if (_discoverController.optionState.value == OptionState.done)
                  ..._discoverController.listGenre.value!.genreData
                      .map((e) => CustomSelectContainer(
                            text: e.name,
                            selected: _discoverController.checkGenre(e),
                            onTap: (selected) {
                              _discoverController.selectGenre(e);
                            },
                            style: normalText.copyWith(
                                fontSize: 10,
                                color: context.colors.secondaryCr),
                          )),
                if (_discoverController.optionState.value ==
                    OptionState.loading)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            );
          }),
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      actions: [
        InkWell(
          onTap: () {
          Get.back();
          },
          child: Container(
            width: getWidth(context, 25),
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: context.colors.secondaryCr,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              "Done",
              style: semiBoldText.copyWith(
                  fontSize: 12, color: context.colors.primaryCr),
            ),
          ),
        )
      ],
      actionsPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    );
  }
}
