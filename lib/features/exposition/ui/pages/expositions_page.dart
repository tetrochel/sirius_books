import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/exposition/data/model/exposition_model.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class ExpositionsPage extends StatelessWidget {
  late final List<int> subscriptions = List.generate(
    4,
    (index) => index * 2,
  );
  late final List<ExpositionModel> expositions = List.generate(
    10,
    (index) => ExpositionModel(
      id: index,
      name: 'Русская классика',
      topic: '',
      location: '',
      bookList: [],
      startDate: DateTime(2025, 2),
      endDate: DateTime(2025, 2, 5),
    ),
  );

  ExpositionsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          pinned: true,
          shadowColor: Colors.black,
          backgroundColor: context.colors.white,
          surfaceTintColor: context.colors.white,
          title: AppBarWidget(
            title: AppLocalizations.of(context)!.expositions,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: context.colors.primary,
                ),
              ),
              IconButton(
                onPressed: () {
                  // TODO(ivan): Добавить вызов модального окна через router
                },
                icon: Icon(
                  Icons.filter_alt,
                  color: context.colors.primary,
                ),
              ),
            ],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: AspectRatio(
                  aspectRatio: 1.5,
                  child: ExpositionWidget(
                    name: expositions[index].name,
                    onTap: () {},
                    onTapSubscribe: () {},
                    isSubscribed: subscriptions.contains(index),
                    startDate: DateFormat('dd.MM.yyyy')
                        .format(expositions[index].startDate),
                    endDate: DateFormat('dd.MM.yyyy')
                        .format(expositions[index].endDate),
                  ),
                ),
              ),
              childCount: expositions.length,
            ),
          ),
        ),
      ],
    );
  }
}
