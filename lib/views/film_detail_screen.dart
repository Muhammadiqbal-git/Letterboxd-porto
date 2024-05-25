import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:letterboxd_porto_3/dimension.dart';
import 'package:letterboxd_porto_3/helpers/diagonal_clipper.dart';
import 'package:letterboxd_porto_3/style.dart';

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
            height: getHeight(context, 40),
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
              top: getHeight(context, 40) - 80,
              left: 20,
              right: 20,
              bottom: 0,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 100,
                            height: 160,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: context.colors.primaryCr,
                                      blurRadius: 4,
                                      spreadRadius: 4),
                                ],
                                borderRadius: BorderRadius.circular(7),
                                image: const DecorationImage(
                                    image: AssetImage("assets/imgs/poster1.png"),
                                    fit: BoxFit.cover)),
                          )
                        ],
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                              height: 5,
                            ),
                             Text(
                              "UNMASK THE TRUTH",
                              style: normalText.copyWith(fontSize: 12),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
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
