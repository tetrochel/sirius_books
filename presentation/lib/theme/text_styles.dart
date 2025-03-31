part of 'theme_picker.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle s14w400;
  final TextStyle s16w600;
  final TextStyle s20w400;
  final TextStyle s24w400;

  const AppTextStyles({
    required this.s14w400,
    required this.s16w600,
    required this.s20w400,
    required this.s24w400,
  });

  @override
  ThemeExtension<AppTextStyles> copyWith({
    TextStyle? s14w400,
    TextStyle? s16w600,
    TextStyle? s20w400,
    TextStyle? s24w400,
  }) {
    return AppTextStyles(
      s14w400: s14w400 ?? this.s14w400,
      s16w600: s16w600 ?? this.s16w600,
      s20w400: s20w400 ?? this.s20w400,
      s24w400: s24w400 ?? this.s24w400,
    );
  }

  @override
  ThemeExtension<AppTextStyles> lerp(
    ThemeExtension<AppTextStyles>? other,
    double t,
  ) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      s14w400: TextStyle.lerp(s14w400, other.s14w400, t)!,
      s16w600: TextStyle.lerp(s16w600, other.s16w600, t)!,
      s20w400: TextStyle.lerp(s20w400, other.s20w400, t)!,
      s24w400: TextStyle.lerp(s24w400, other.s24w400, t)!,
    );
  }
}
