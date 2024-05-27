import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letterboxd_porto_3/dimension.dart';

class ReviewController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;

  Future<void> datePicker(BuildContext context) async {
    DateTime now = selectedDate.value;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2018, 8),
      lastDate: now,
      builder: (context, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 400 + getHeight(context, 10),
            width: 250 + getWidth(context, 15),
            child: child,
          )
        ],
      ),
    );
    if (picked != null && picked != now) {
      selectedDate.value = picked;
    }
  }
}
