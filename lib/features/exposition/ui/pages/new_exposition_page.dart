import 'package:flutter/material.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/config/constants.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/books_collection/data/model/book_collection_model.dart';
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

  late final List<CollectionModel> collections = [
    CollectionModel(
      firebaseId: 1.toString(),
      name: 'Классика',
      description: 'Коллекция классической литературы',
      books: [
        BookModel(
          name: 'Война и мир',
          authorName: 'Лев Толстой',
          publicationYear: 1869,
          publisher: 'АСТ',
          genre: 'Роман',
          isbn: '978-5-17-118366-3',
          cover: Cover.hard,
          pagesCount: 1225,
          booksCount: 5,
          price: 1500.0,
          weight: 1200,
          location: 'Москва, ул. Ленина, д. 10',
        ),
        BookModel(
          name: 'Преступление и наказание',
          authorName: 'Фёдор Достоевский',
          publicationYear: 1866,
          publisher: 'Эксмо',
          genre: 'Роман',
          isbn: '978-5-04-116437-3',
          cover: Cover.hard,
          pagesCount: 672,
          booksCount: 3,
          price: 1200.0,
          weight: 900,
          location: 'Санкт-Петербург, Невский проспект, д. 20',
        ),
      ],
    ),
    CollectionModel(
      firebaseId: 2.toString(),
      name: 'Фантастика',
      description: 'Лучшие книги в жанре научной фантастики',
      books: [
        BookModel(
          name: 'Дюна',
          authorName: 'Фрэнк Герберт',
          publicationYear: 1965,
          publisher: 'Азбука',
          genre: 'Фантастика',
          isbn: '978-5-389-15844-3',
          cover: Cover.jacket,
          pagesCount: 704,
          booksCount: 4,
          price: 1800.0,
          weight: 1100,
          location: 'Москва, ул. Арбат, д. 5',
        ),
        BookModel(
          name: '1984',
          authorName: 'Джордж Оруэлл',
          publicationYear: 1949,
          publisher: 'АСТ',
          genre: 'Антиутопия',
          isbn: '978-5-17-080201-4',
          cover: Cover.soft,
          pagesCount: 320,
          booksCount: 6,
          price: 800.0,
          weight: 500,
          location: 'Екатеринбург, ул. Ленина, д. 7',
        ),
      ],
    ),
  ];
  late final List<BookModel> books;

  DateTime? startDate;
  DateTime? endDate;

  int? selectedCollectionId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
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
                      onSelected: (selected) =>
                          selectedCollectionId = selected as int,
                      expandedInsets: EdgeInsets.zero,
                      initialSelection: selectedCollectionId,
                      label: Text(AppLocalizations.of(context)!.collection),
                      inputDecorationTheme: InputDecorationTheme(
                        labelStyle: context.textStyles.s14w400
                            .copyWith(color: context.colors.grey),
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
                      onPressed: () {},
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
