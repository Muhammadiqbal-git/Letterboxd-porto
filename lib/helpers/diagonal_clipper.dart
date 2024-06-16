import 'package:flutter/material.dart';

class DiagonalClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height*0.60);
    path.lineTo(0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}