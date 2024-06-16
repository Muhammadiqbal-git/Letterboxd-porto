import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomImgNetwork extends StatefulWidget {
  final String path;
  final BorderRadius? radius;
  final Alignment? align;
  const CustomImgNetwork(
      {super.key, required this.path, this.radius, this.align});

  @override
  State<CustomImgNetwork> createState() => _CustomImgNetworkState();
}

class _CustomImgNetworkState extends State<CustomImgNetwork> {
  @override
  Widget build(BuildContext context) {
    if (widget.path == "") {
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
    }
    return ClipRRect(
      borderRadius: widget.radius ?? BorderRadius.circular(7),
      child: CachedNetworkImage(
        imageUrl: widget.path,
        fit: BoxFit.cover,
        placeholderFadeInDuration: const Duration(milliseconds: 200),
        placeholder: (context, url) =>  Skeletonizer(
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
          ),
        errorWidget: (context, url, error) {
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
