import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomImgNetwork extends StatefulWidget {
  final String path;
  final BorderRadius? radius;
  final Alignment? align;
  const CustomImgNetwork({super.key, required this.path, this.radius, this.align});

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
          decoration: BoxDecoration(color: context.colors.whiteCr.withOpacity(0.8)),
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
      child: Image.network(
        widget.path,
        fit: BoxFit.cover,
        alignment: widget.align?? Alignment.center,
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
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
