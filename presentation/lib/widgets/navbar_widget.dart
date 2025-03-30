import 'package:flutter/material.dart';
import 'package:presentation/theme/theme_picker.dart';

class NavBar extends StatelessWidget {
  final String expositionsLabel;
  final IconData expositionsIcon;
  final String booksLabel;
  final IconData booksIcon;
  final String collectionsLabel;
  final IconData collectionsIcon;
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  const NavBar({
    super.key,
    required this.expositionsLabel,
    required this.expositionsIcon,
    required this.booksLabel,
    required this.booksIcon,
    required this.collectionsLabel,
    required this.collectionsIcon,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: context.colors.primary,
      unselectedItemColor: context.colors.grey,
      items: [
        BottomNavigationBarItem(
          icon: Icon(expositionsIcon),
          label: expositionsLabel,
        ),
        BottomNavigationBarItem(icon: Icon(booksIcon), label: booksLabel),
        BottomNavigationBarItem(
          icon: Icon(collectionsIcon),
          label: collectionsLabel,
        ),
      ],
      currentIndex: currentIndex,
      onTap: onTabSelected,
    );
  }
}
