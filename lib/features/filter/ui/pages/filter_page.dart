import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) => CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            shadowColor: Colors.black,
            backgroundColor: context.colors.white,
            surfaceTintColor: context.colors.white,
            title: AppBarWidget(
              title: AppLocalizations.of(context)!.filter,
              actions: const [],
            ),
          ),
        ],
      ),
    );
  }
}
