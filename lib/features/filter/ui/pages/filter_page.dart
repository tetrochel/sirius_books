import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:presentation/widgets/filters/enum_filter_widget.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/book/ui/bloc/book_bloc.dart';
import 'package:sirius_books/features/book/ui/bloc/book_event.dart';
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
            onChanged: (value) {
              context.read<BookBloc>().add(
                    OnFilterChanged(
                      id: filter.id,
                      value: value,
                    ),
                  );
            },
          );
        case SubrangeFilterModel():
          return SubrangeFilterWidget(
            id: filter.id,
            name: _names[filter.id]!,
            min: filter.min,
            max: filter.max,
            onChanged: (value) {
              context.read<BookBloc>().add(
                    OnFilterChanged(
                      id: filter.id,
                      value: value,
                    ),
                  );
            },
          );
        case EnumFilterModel():
          return EnumFilterWidget(
            id: filter.id,
            name: _names[filter.id]!,
            enums: Cover.values,
            // TODO(ivan): добавить локализацию
            names: const ['Мягкий', 'Твердый', 'Супер'],
            onChanged: (selection) {
              context.read<BookBloc>().add(
                    OnFilterChanged(
                      id: filter.id,
                      value: selection,
                    ),
                  );
            },
          );
      }
    }).toList();
    return SliderTheme(
      data: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
      child: DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                  actions: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: const Icon(
                        Icons.close,
                      ),
                    ),
                  ],
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
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 16),
                sliver: SliverToBoxAdapter(
                  child: AppButton(
                    type: ButtonType.primary,
                    onPressed: () {
                      context.read<BookBloc>().add(OnFilterBooks());
                      context.pop();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.apply,
                      style: context.textStyles.s16w600.copyWith(color: context.colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
