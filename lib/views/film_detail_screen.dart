import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:letterboxd_porto_3/dimension.dart';
import 'package:letterboxd_porto_3/helpers/diagonal_clipper.dart';
import 'package:letterboxd_porto_3/style.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_button.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_review_card.dart';

class FilmDetailScreen extends StatelessWidget {
  const FilmDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Image.asset(
                "assets/imgs/banner.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              top: getHeight(context, 30) - 80,
              left: 20,
              right: 20,
              bottom: 0,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //left Section (Image)
                      Column(
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
                                borderRadius: BorderRadius.circular(7),
                                image: const DecorationImage(
                                    image:
                                        AssetImage("assets/imgs/poster1.png"),
                                    fit: BoxFit.cover)),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Column(
                                children: [
                                  const ImageIcon(
                                    AssetImage("assets/icons/view.png"),
                                    size: 14,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    "40k",
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
                                    AssetImage("assets/icons/liked.png"),
                                    color: Colors.red,
                                    size: 14,
                                  ),
                                  Text(
                                    "40k",
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
                                    "40k",
                                    style: normalText.copyWith(fontSize: 8),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
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
                                        const AssetImage(
                                            "assets/icons/review.png"),
                                        color: context.colors.primaryCr,
                                        size: 14,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Rate or Review",
                                        style: boldText.copyWith(
                                            fontSize: 8,
                                            color: context.colors.primaryCr),
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
                                          fontSize: 8,
                                          color: context.colors.primaryCr),
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
                                      const AssetImage(
                                          "assets/icons/watchlist.png"),
                                      color: context.colors.primaryCr,
                                      size: 14,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Add to Watchlist",
                                      style: boldText.copyWith(
                                          fontSize: 8,
                                          color: context.colors.primaryCr),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      // Righ Section (Title)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                                Text(
                                  "172 mins",
                                  style: normalText.copyWith(fontSize: 11),
                                )
                              ],
                            ),
                            Text(
                              "Directed by Matt Reeves",
                              style: normalText.copyWith(fontSize: 12),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "UNMASK THE TRUTH \n\nIn his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.",
                              style: normalText.copyWith(fontSize: 10),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Ratings",
                              style: normalText.copyWith(color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 50,
                                  width: 80,
                                  color: context.colors.whiteCr,
                                ),
                                const Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      "4.4",
                                      style: semiBoldText.copyWith(
                                          fontSize: 30,
                                          color: context.colors.secondaryCr),
                                    ),
                                    Row(
                                      children: List.generate(
                                        5,
                                        (index) => const Icon(
                                          Icons.star,
                                          size: 10,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 20,
                            width: 45,
                            margin: EdgeInsets.only(bottom: 4),
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
                          Container(
                            height: 2,
                            width: 30,
                            color: context.colors.accentCr,
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 20,
                        width: 45,
                        margin: EdgeInsets.only(bottom: 4),
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
                        margin: EdgeInsets.only(bottom: 4),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    alignment: Alignment.centerLeft,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) => Container(
                              height: 45,
                              width: 45,
                              margin:
                                  EdgeInsets.only(right: index == 4 ? 0 : 10),
                              decoration: BoxDecoration(
                                  color: context.colors.whiteCr,
                                  borderRadius: BorderRadius.circular(50)),
                            )),
                  ),
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
                    margin: EdgeInsets.only(top: 3),
                    color: context.colors.whiteCr.withOpacity(0.3),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomReviewCard(
                    withImage: false,
                  )
                ],
              )),
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
