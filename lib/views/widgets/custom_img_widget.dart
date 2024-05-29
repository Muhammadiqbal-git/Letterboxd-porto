import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/helpers/style.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomImgNetwork extends StatefulWidget {
  final String path;
  const CustomImgNetwork({super.key, required this.path});

  @override
  State<CustomImgNetwork> createState() => _CustomImgNetworkState();
}

class _CustomImgNetworkState extends State<CustomImgNetwork> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Image.network(
        widget.path,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return Skeletonizer(
              child: Skeleton.leaf(
                child: Container(
                  decoration: BoxDecoration(color: context.colors.whiteCr),
                  alignment: Alignment.center,
                  child: Icon(Icons.more_horiz, color: context.colors.primaryCr,),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
