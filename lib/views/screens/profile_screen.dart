import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/dimension.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_review_card.dart';

class ProfileScreen extends StatelessWidget {
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
              CircleAvatar(
                backgroundColor: context.colors.whiteCr,
                radius: 40,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Nama",
                style: boldText,
              ),
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
                          const Text(
                            "500 Followers",
                            style: normalText,
                          ),
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
                          const Text(
                            "500 Following",
                            style: normalText,
                          ),
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
                      Text(
                        "455",
                        style: boldText.copyWith(
                            fontSize: 20, color: context.colors.secondaryCr),
                      ),
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
                      Text(
                        "33",
                        style: boldText.copyWith(
                            fontSize: 20, color: context.colors.accentCr),
                      ),
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
                        "4",
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
                      Text(
                        "30",
                        style: boldText.copyWith(
                            fontSize: 20, color: context.colors.accentCr),
                      ),
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
              const Text(
                "Nama's Favorite Films",
                style: semiBoldText,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    width: 60,
                    color: context.colors.whiteCr,
                    margin: EdgeInsets.only(right: index == 3 ? 0 : 10),
                  ),
                ),
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
      physics: AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(23),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nama's Recent Watched",
                style: semiBoldText.copyWith(fontSize: 12),
              ),
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
          SizedBox(
            height: 120,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80,
                    width: 60,
                    margin: EdgeInsets.only(right: index == 4 ? 0 : 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      image: const DecorationImage(
                          image: AssetImage("assets/imgs/poster1.png"),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Row(
                    children: List.generate(
                        5,
                        (index) => const Icon(
                              Icons.star,
                              size: 10,
                              color: Colors.red,
                            )),
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
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nama's Recent Reviewed",
                style: semiBoldText.copyWith(fontSize: 12),
              ),
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
          CustomReviewCard(),
        ],
      ),
    );
  }
}
