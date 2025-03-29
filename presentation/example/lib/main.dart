import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        extensions: [
          AppColors(
            primary: const Color(0xFF019DA1),
            grey: const Color(0xFF7F8585),
            white: const Color(0xFFFFFFFF),
          ),
          AppTextStyles(
            s14w400: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            s16w600: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            s24w400: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      home: Scaffold(
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) => BookWidget(
            name: "Евгений Онегин",
            authorName: "Александр Пушкин",
            genre: "Роман",
            isFavorite: index % 2 == 0,
            onTap: () {},
            onTapFavorite: () {},
          ),
        ),
      ),
    );
  }
}
