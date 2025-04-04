import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/config/constants.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/books_collection/ui/bloc/collection_bloc.dart';
import 'package:sirius_books/features/books_collection/ui/bloc/collection_event.dart';
import 'package:sirius_books/features/exposition/data/model/exposition_model.dart';
import 'package:sirius_books/features/exposition/ui/bloc/exposition_bloc.dart';
import 'package:sirius_books/features/exposition/ui/bloc/exposition_event.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class NewExpositionPage extends StatefulWidget {
  const NewExpositionPage({super.key});

  @override
  State<NewExpositionPage> createState() => _NewExpositionPageState();
}

class _NewExpositionPageState extends State<NewExpositionPage> {
  final nameController = TextEditingController();
  final topicController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  late final List<BookModel> books;

  DateTime? startDate;
  DateTime? endDate;

  String? selectedCollectionId;

  @override
  Widget build(BuildContext context) {
    context.watch<CollectionBloc>().add(OnLoadCollections());
    final collections = context.watch<CollectionBloc>().state.collectionList;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverAppBar(
              titleSpacing: 0,
              pinned: true,
              shadowColor: Colors.black,
              backgroundColor: context.colors.white,
              surfaceTintColor: context.colors.white,
              title: AppBarWidget(
                title: AppLocalizations.of(context)!.new_exposition,
                actions: const [],
                disablePadding: true,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  [
                    TextFieldWithLabelWidget(
                      label: AppLocalizations.of(context)!.title,
                      textController: nameController,
                      readOnly: false,
                    ),
                    const SizedBox(height: 12),
                    TextFieldWithLabelWidget(
                      textController: descriptionController,
                      label: AppLocalizations.of(context)!.description,
                      textInputType: TextInputType.multiline,
                      readOnly: false,
                    ),
                    const SizedBox(height: 12),
                    DateFieldWidget(
                      onTap: () => _selectDate(context, false),
                      controller: startDateController,
                      label: AppLocalizations.of(context)!.startDate,
                    ),
                    const SizedBox(height: 12),
                    DateFieldWidget(
                      onTap: () => _selectDate(context, true),
                      controller: endDateController,
                      label: AppLocalizations.of(context)!.endDate,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppLocalizations.of(context)!.collection,
                      style: context.textStyles.s16w600,
                    ),
                    const SizedBox(height: 4),
                    DropdownMenu(
                      onSelected: (selected) => selectedCollectionId = selected,
                      expandedInsets: EdgeInsets.zero,
                      initialSelection: selectedCollectionId,
                      label: Text(
                        AppLocalizations.of(context)!.collection,
                        style: context.textStyles.s14w400,
                      ),
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: context.textStyles.s14w400.copyWith(color: context.colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: context.colors.grey,
                            width: 1.5,
                          ),
                        ),
                      ),
                      dropdownMenuEntries: collections
                          .map(
                            (collection) => DropdownMenuEntry(
                              value: collection.firebaseId,
                              label: collection.name,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    AppButton(
                      type: ButtonType.primary,
                      onPressed: () {
                        final selectedCollection = collections.firstWhere(
                          (collection) => collection.firebaseId == selectedCollectionId.toString(),
                        );

                        context.read<ExpositionBloc>().add(
                              OnAddExpositionPressed(
                                expositionModel: ExpositionModel(
                                  name: nameController.text,
                                  topic: topicController.text,
                                  description: descriptionController.text,
                                  books: selectedCollection.books,
                                  location: locationController.text,
                                  startDate: startDate!,
                                  endDate: endDate!,
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

  Future<void> _selectDate(BuildContext context, bool isEndDate) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (!context.mounted) {
      return;
    }

    if (picked != null) {
      if (isEndDate) {
        if (startDate != null && picked.isBefore(startDate!)) {
          _showErrorDialog(
            AppLocalizations.of(context)!.errorStartDateAfterEndDate,
          );
          return;
        }
        endDate = picked;
        endDateController.text = defaultDateFormat.format(endDate!);
      } else {
        if (endDate != null && picked.isAfter(endDate!)) {
          _showErrorDialog(
            AppLocalizations.of(context)!.errorStartDateAfterEndDate,
          );
          return;
        }
        startDate = picked;
        startDateController.text = defaultDateFormat.format(startDate!);
      }
      setState(() {});
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.error),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('ОК'),
          ),
        ],
      ),
    );
  }
}
