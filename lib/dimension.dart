
import 'package:flutter/material.dart';

double getWidth(BuildContext context, int size) {
  return MediaQuery.of(context).size.width * (size / 100);
}

double getHeight(BuildContext context, int size) {
  return MediaQuery.of(context).size.height * (size / 100);
}