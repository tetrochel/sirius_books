import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/books_collection/data/model/book_collection_model.dart';
import 'package:sirius_books/features/books_collection/ui/bloc/collection_bloc.dart';
import 'package:sirius_books/features/books_collection/ui/bloc/collection_event.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class NewCollectionPage extends StatefulWidget {
  const NewCollectionPage({super.key});

  @override
  State<NewCollectionPage> createState() => _NewCollectionPageState();
}

class _NewCollectionPageState extends State<NewCollectionPage> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              titleSpacing: 0,
              pinned: true,
              shadowColor: Colors.black,
              backgroundColor: context.colors.white,
              surfaceTintColor: context.colors.white,
              title: AppBarWidget(
                title: AppLocalizations.of(context)!.newCollection,
                actions: const [],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    TextFieldWithLabelWidget(
                      label: AppLocalizations.of(context)!.name,
                      textController: nameController,
                      readOnly: false,
                    ),
                    TextFieldWithLabelWidget(
                      textInputType: TextInputType.multiline,
                      label: AppLocalizations.of(context)!.description,
                      textController: descriptionController,
                      readOnly: false,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverFillRemaining(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppButton(
                      type: ButtonType.primary,
                      onPressed: () {
                        context.read<CollectionBloc>().add(
                              OnAddCollection(
                                collectionModel: CollectionModel(
                                  name: nameController.text,
                                  description: descriptionController.text,
                                  books: [],
                                ),
                              ),
                            );
                        context.pop();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.create,
                        style: context.textStyles.s14w400.copyWith(
                          color: context.colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
