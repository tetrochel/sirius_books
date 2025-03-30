import 'package:flutter/material.dart';
import 'package:presentation/theme/theme_picker.dart';

class NavBar extends StatelessWidget {
  final List<({String label, IconData icon})> items;
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const NavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        splashFactory: InkRipple.splashFactory,
      ),
      child: BottomNavigationBar(
        selectedItemColor: context.colors.primary,
        unselectedItemColor: context.colors.grey,
        backgroundColor: context.colors.white,
        items: items
            .map(
              (item) => BottomNavigationBarItem(
                icon: Icon(item.icon),
                label: item.label,
              ),
            )
            .toList(),
        currentIndex: currentIndex,
        onTap: onTabSelected,
      ),
    );
  }
}
