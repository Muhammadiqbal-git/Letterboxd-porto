import 'package:flutter/material.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primaryCr;
  final Color secondaryCr;
  final Color accentCr;
  final Color whiteCr;

  const AppColors({
    required this.primaryCr,
    required this.secondaryCr,
    required this.accentCr,
    required this.whiteCr,
  });

  @override
  AppColors copyWith({
    Color? primaryCr,
    Color? secondaryCr,
    Color? accentCr,
    Color? whiteCr,
  }) {
    return AppColors(
      primaryCr: primaryCr ?? this.primaryCr,
      secondaryCr: secondaryCr ?? this.secondaryCr,
      accentCr: accentCr ?? this.accentCr,
      whiteCr: whiteCr ?? this.whiteCr,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primaryCr: Color.lerp(primaryCr, other.primaryCr, t)!,
      secondaryCr: Color.lerp(secondaryCr, other.secondaryCr, t)!,
      accentCr: Color.lerp(accentCr, other.accentCr, t)!,
      whiteCr: Color.lerp(whiteCr, other.whiteCr, t)!,
    );
  }
}
