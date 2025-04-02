import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:presentation/widgets/filters/enum_filter_widget.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/filter/data/model/filter_model.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class FilterPage extends StatelessWidget {
  final Map<String, String> _names = {};

  FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    _setNames(context);
    final filterWidgets = Filters.filters.map((filter) {
      switch (filter) {
        case SubStringFilterModel():
          return SubStringFilterWidget(
            id: filter.id,
            name: _names[filter.id]!,
          );
        case SubrangeFilterModel():
          return SubrangeFilterWidget(
            id: filter.id,
            name: _names[filter.id]!,
            min: filter.min,
            max: filter.max,
          );
        case EnumFilterModel():
          return EnumFilterWidget(
            id: filter.id,
            name: _names[filter.id]!,
            enums: Cover.values,
            // TODO(ivan): добавить локализацию
            names: const ['Мягкий', 'Твердый', 'Супер'],
          );
        default:
          return const SizedBox.shrink();
      }
    }).toList();
    return SliderTheme(
      data: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
      child: DraggableScrollableSheet(
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
                title: AppLocalizations.of(context)!.filters,
                actions: const [],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  filterWidgets,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setNames(BuildContext context) {
    _names['name'] = AppLocalizations.of(context)!.name;
    _names['authorName'] = AppLocalizations.of(context)!.authorName;
    _names['publicationYear'] = AppLocalizations.of(context)!.year;
    _names['publisher'] = AppLocalizations.of(context)!.publisher;
    _names['genre'] = AppLocalizations.of(context)!.genre;
    _names['isbn'] = AppLocalizations.of(context)!.isbn;
    _names['cover'] = AppLocalizations.of(context)!.cover;
    _names['pagesCount'] = AppLocalizations.of(context)!.pagesCount;
    _names['booksCount'] = AppLocalizations.of(context)!.booksCount;
    _names['price'] = AppLocalizations.of(context)!.price;
    _names['weight'] = AppLocalizations.of(context)!.weight;
    _names['location'] = AppLocalizations.of(context)!.location;
  }
}
