import 'package:flutter/material.dart';

part 'text_styles.dart';
part 'app_colors.dart';

extension ThemePicker on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  AppTextStyles get textStyles => Theme.of(this).extension<AppTextStyles>()!;
}
