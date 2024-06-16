import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:letterboxd_porto_3/controllers/profile_controller.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';

import '../widgets/custom_img_widget.dart';
import 'profile_screen.dart';

class NotificationScreen extends GetView<ProfileController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 56,
          alignment: Alignment.center,
          child: Text(
            "Notification",
            style: boldText.copyWith(fontSize: 20),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Material(
              color: context.colors.secondaryAccentCr,
              borderRadius: BorderRadius.circular(7),
              child: Obx(() {
                if (controller.notif.value == null) {
                  return const Center(
                    child: Text(
                      "No notification yet",
                      style: semiBoldText,
                    ),
                  );
                } else {
                  return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 17, vertical: 22),
                      itemCount: controller.notif.value!.listNotif.length,
                      itemBuilder: (context, index) {
                        var data = controller.notif.value!.listNotif[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(7),
                            onTap: () {
                              controller.readNotif(data.docId);
                              Get.find<ProfileController>()
                                  .readOtherProfile(data.uId);
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              decoration: BoxDecoration(
                                color: data.read
                                    ? context.colors.primaryCr.withOpacity(0.35)
                                    : context.colors.primaryCr.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: CustomImgNetwork(
                                        radius: BorderRadius.circular(50),
                                        path: data.photoPath ?? ""),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.uName,
                                              style: normalText.copyWith(
                                                  fontSize: 12),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              data.event,
                                              style: normalText.copyWith(
                                                  fontSize: 10,
                                                  color: context.colors.whiteCr
                                                      .withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              DateFormat("d-MM-y")
                                                  .format(data.date),
                                              style: normalText.copyWith(
                                                  fontSize: 9,
                                                  color: context.colors.whiteCr
                                                      .withOpacity(0.6)),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              DateFormat("HH:mm")
                                                  .format(data.date),
                                              style: normalText.copyWith(
                                                  fontSize: 9,
                                                  color: context.colors.whiteCr
                                                      .withOpacity(0.6)),
                                            ),
                                          ],
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
                }
              }),
            ),
          ),
        )
      ],
    );
  }
}
