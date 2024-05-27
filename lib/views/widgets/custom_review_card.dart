import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/style.dart';

class CustomReviewCard extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? bgColor;
  final bool withImage;

  const CustomReviewCard(
      {super.key,
      this.width,
      this.height,
      this.bgColor,
      this.withImage = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.maxFinite,
      height: height ?? 125,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: context.colors.secondaryCr.withOpacity(0.1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(7),
              bottomLeft: Radius.circular(7),
              bottomRight: Radius.circular(7))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: context.colors.whiteCr,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 3,
                ),
                if (withImage)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "The Irishman ",
                        style: boldText.copyWith(fontSize: 12),
                      ),
                      Text(
                        "2020",
                        style: normalText.copyWith(
                            fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                if (!withImage)
                  const SizedBox(
                    height: 6,
                  ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    Text("Review by ",
                        style: semiBoldText.copyWith(fontSize: 12)),
                    Text(
                      "Namess",
                      style: semiBoldText.copyWith(
                          fontSize: 12, color: context.colors.secondaryCr),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      "****",
                      style: semiBoldText.copyWith(fontSize: 12),
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ImageIcon(
                          AssetImage("assets/icons/reply.png"),
                          size: 10,
                          color: context.colors.whiteCr,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          "2",
                          style: normalText.copyWith(
                              fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  "working stiffs. \nnot sure i've ever mentioned this before but i have a very personal fear of not... feeling... correctly. like enormously important things are happening around you in a matter-of-fact, dissociative way that you can understand the significance of but you can't shake..",
                  style: normalText.copyWith(
                    fontSize: 10,
                    color: context.colors.whiteCr,
                  ),
                  maxLines: 4,
                  textAlign: TextAlign.justify,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      "Read more",
                      style: normalText.copyWith(
                          fontSize: 10, color: context.colors.accentCr),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 10,
                      color: context.colors.accentCr,
                    )
                  ],
                )
              ],
            ),
          ),
          if (withImage) ...[
            Spacer(
              flex: 1,
            ),
            Container(
              height: double.maxFinite,
              width: 77,
              decoration: BoxDecoration(
                  color: context.colors.whiteCr,
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                      image: AssetImage("assets/imgs/poster1.png"),
                      fit: BoxFit.cover)),
            )
          ],
          if (!withImage)
            const SizedBox(
              width: 20,
            )
        ],
      ),
    );
  }
}
