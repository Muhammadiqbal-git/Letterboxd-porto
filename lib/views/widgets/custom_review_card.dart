import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomReviewCard extends StatelessWidget {
  final String titleFilm;
  final String author;
  final String yearFilm;
  final String review;
  final double rate;
  final double? width;
  final double? height;
  final Color? bgColor;
  final bool withImage;
  final bool loading;

  const CustomReviewCard(
      {super.key,
      required this.titleFilm,
      required this.author,
      required this.yearFilm,
      required this.review,
      required this.rate,
      this.width,
      this.height,
      this.bgColor,
      this.loading = false,
      this.withImage = true});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: loading,
      containersColor: context.colors.whiteCr.withOpacity(0.5),
      child: Container(
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
            Skeleton.shade(
              child: CircleAvatar(
                backgroundColor: context.colors.whiteCr,
              ),
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
                          "$titleFilm",
                          style: boldText.copyWith(fontSize: 12),
                        ),
                        Text(
                          " $yearFilm",
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
                        "$author",
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
                      Skeleton.unite(
                        child: Row(
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
                        ),
                      )
                    ],
                  ),
                  Text(
                    review,
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
                  Skeleton.unite(
                    child: Row(
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
                    ),
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
      ),
    );
  }
}
