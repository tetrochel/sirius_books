part of 'theme_picker.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color primary;
  final Color grey;
  final Color white;

  const AppColors({
    required this.primary,
    required this.grey,
    required this.white,
  });

  @override
  ThemeExtension<AppColors> copyWith({
    Color? primary,
    Color? grey,
    Color? white,
  }) {
    return AppColors(
      primary: primary ?? this.primary,
      grey: grey ?? this.grey,
      white: white ?? this.white,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      white: Color.lerp(white, other.white, t)!,
    );
  }
}
