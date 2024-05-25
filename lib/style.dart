import 'package:flutter/material.dart';
import 'package:letterboxd_porto_3/app_color.dart';

extension BuildContextExt on BuildContext{
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

const TextStyle normalText =
    TextStyle(fontFamily: "Open Sans", color: Color(0xFFFFFFFF));
const TextStyle italicText = TextStyle(
    fontFamily: "Open Sans", fontStyle: FontStyle.italic, color: Color(0xFFFFFFFF));
const TextStyle boldText = TextStyle(
    fontFamily: "Open Sans", fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF));
const TextStyle semiBoldText = TextStyle(
    fontFamily: "Open Sans", fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF));
