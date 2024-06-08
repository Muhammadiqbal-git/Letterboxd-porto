import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:letterboxd_porto_3/controllers/tmdb_services.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:letterboxd_porto_3/models/review_snapshot_model.dart';
import 'package:letterboxd_porto_3/views/widgets/custom_img_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomReviewCard extends StatelessWidget {
  final ReviewEntityModel? reviewData;
  final double? width;
  final double? height;
  final Color? bgColor;
  final bool withImage;
  final bool loading;

  const CustomReviewCard(
      {super.key,
      required this.reviewData,
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
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(7),
                bottomLeft: Radius.circular(7),
                bottomRight: Radius.circular(7))),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Skeleton.shade(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Builder(
                      builder: (context) {
                        return CustomImgNetwork(
                            radius: BorderRadius.circular(50),
                            path: reviewData?.photoPath ?? "");
                      }
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const SizedBox(
                          height: 5,
                        ),
                      if (withImage)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Flexible(
                              child: Text(
                                (reviewData?.filmInfoModel.filmTitle) ?? "Title",
                                style: boldText.copyWith(fontSize: 12),
                              ),
                            ),
                            Builder(builder: (context) {
                              if (reviewData?.filmInfoModel.filmYear != null) {
                                return Text(
                                  " ${DateFormat("yyyy").format(reviewData!.filmInfoModel.filmYear!)}",
                                  style: normalText.copyWith(
                                      fontSize: 10, color: Colors.grey),
                                );
                              }
                              return Text(
                                " ${(reviewData?.filmInfoModel.filmYear) ?? " 2024"}",
                                style: normalText.copyWith(
                                    fontSize: 10, color: Colors.grey),
                              );
                            }),
                          ],
                        ),
                      if (withImage)
                        const SizedBox(
                          height: 3,
                        ),

                      Row(
                        children: [
                          Text("Review by ",
                              style: semiBoldText.copyWith(fontSize: 12, color: context.colors.whiteCr.withOpacity(0.6))),
                          Text(
                            reviewData?.uName ?? "Nama",
                            style: semiBoldText.copyWith(
                                fontSize: 12,
                                color: context.colors.secondaryCr),
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
                        reviewData?.reviewText ?? "lorem ipsum",
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
                    child: Builder(builder: (context) {
                      return CustomImgNetwork(
                          path: TMDBServices().imgUrl(
                              width: 154,
                              pathUrl: reviewData?.filmInfoModel.filmPosterPath ?? ""));
                    }),
                  )
                ],
                if (!withImage)
                  const SizedBox(
                    width: 20,
                  )
              ],
            ),
            Positioned(
                bottom: 15,
                right: withImage ? 90 : 20,
                child: Skeleton.unite(
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
                ))
          ],
        ),
      ),
    );
  }
}
