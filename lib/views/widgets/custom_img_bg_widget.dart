import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomImgBgNetwork extends StatefulWidget {
  final String path;
  final BorderRadius? radius;
  final Alignment? align;
  const CustomImgBgNetwork(
      {super.key, required this.path, this.radius, this.align});

  @override
  State<CustomImgBgNetwork> createState() => _CustomImgBgNetworkState();
}

class _CustomImgBgNetworkState extends State<CustomImgBgNetwork> {
  @override
  Widget build(BuildContext context) {
    print(widget.path);
    if (widget.path == "") {
      return Image.asset(
        "assets/imgs/onboarding.png",
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      );
    }
    return ClipRRect(
      child: Image.network(
        widget.path,
        fit: BoxFit.cover,
        alignment: widget.align ?? Alignment.center,
        // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        //   return Skeletonizer(
        //       enabled: false, child: Skeleton.leaf(child: child));
        // },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Skeletonizer(
              enabled: true,
              child: Skeleton.leaf(
                child: SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Icon(
                    Icons.more_horiz,
                    color: context.colors.primaryCr,
                  ),
                ),
              ),
            );
          }
        },
        errorBuilder: (context, error, stackTrace) {
          return ClipRRect(
            borderRadius: widget.radius ?? BorderRadius.circular(7),
            child: Container(
              decoration:
                  BoxDecoration(color: context.colors.whiteCr.withOpacity(0.8)),
              alignment: Alignment.center,
              child: Icon(
                Icons.no_accounts,
                color: context.colors.primaryCr,
              ),
            ),
          );
        },
      ),
    );
  }
}
