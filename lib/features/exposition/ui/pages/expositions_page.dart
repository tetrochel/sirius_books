import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/config/constants.dart';
import 'package:sirius_books/features/exposition/ui/bloc/exposition_bloc.dart';
import 'package:sirius_books/features/exposition/ui/bloc/exposition_event.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class ExpositionsPage extends StatelessWidget {
  const ExpositionsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final expositions = context.watch<ExpositionBloc>().state.expositionModelList;
    return CustomScrollView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      slivers: [
        SliverAppBar(
          pinned: true,
          shadowColor: Colors.black,
          backgroundColor: context.colors.white,
          surfaceTintColor: context.colors.white,
          title: AppBarWidget(
            title: AppLocalizations.of(context)!.expositions,
            actions: const [],
          ),
        ),
        CupertinoSliverRefreshControl(
          onRefresh: () async => context.read<ExpositionBloc>().add(OnLoadExposition()),
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
                    onTap: () {
                      context.push(
                        '/expositions/details',
                        extra: expositions[index],
                      );
                    },
                    onTapSubscribe: () {},
                    isSubscribed: false,
                    startDate: defaultDateFormat.format(expositions[index].startDate),
                    endDate: defaultDateFormat.format(expositions[index].endDate),
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
