part of 'theme_picker.dart';

class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle s14w400;
  final TextStyle s16w600;

  const AppTextStyles({
    required this.s14w400,
    required this.s16w600,
  });

  @override
  ThemeExtension<AppTextStyles> copyWith({
    TextStyle? s14w400,
    TextStyle? s16w600,
  }) {
    return AppTextStyles(
      s14w400: s14w400 ?? this.s14w400,
      s16w600: s16w600 ?? this.s16w600,
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
    );
  }
}
