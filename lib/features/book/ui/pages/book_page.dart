import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/book/ui/bloc/book_bloc.dart';
import 'package:sirius_books/features/book/ui/bloc/book_event.dart';
import 'package:sirius_books/features/user/data/model/user_model.dart';
import 'package:sirius_books/features/user/ui/bloc/user_bloc.dart';
import 'package:sirius_books/generated/app_localizations.dart';

enum Mode { view, edit }

class BookPage extends StatefulWidget {
  final Mode mode;
  final BookModel? book;

  const BookPage({required this.mode, this.book, super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  final List<String> covers = const ['Мягкий', 'Твердый', 'Супер'];

  late Mode mode;
  late final TextEditingController nameController;
  late final TextEditingController authorController;
  late final TextEditingController publicationYearController;
  late final TextEditingController publisherController;
  late final TextEditingController genreController;
  late final TextEditingController isbnController;
  late final TextEditingController pagesCountController;
  late final TextEditingController booksCountController;
  late final TextEditingController priceController;
  late final TextEditingController weightController;
  late final TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    mode = widget.mode;
    nameController = TextEditingController(text: widget.book?.name);
    authorController = TextEditingController(text: widget.book?.authorName);
    publicationYearController =
        TextEditingController(text: widget.book?.publicationYear.toString());
    publisherController = TextEditingController(text: widget.book?.publisher);
    genreController = TextEditingController(text: widget.book?.genre);
    isbnController = TextEditingController(text: widget.book?.isbn);
    pagesCountController =
        TextEditingController(text: widget.book?.pagesCount.toString());
    booksCountController =
        TextEditingController(text: widget.book?.booksCount.toString());
    priceController =
        TextEditingController(text: widget.book?.price.toString());
    weightController =
        TextEditingController(text: widget.book?.weight.toString());
    locationController = TextEditingController(text: widget.book?.location);
  }

  @override
  Widget build(BuildContext context) {
    final readOnly = mode == Mode.view;
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            shadowColor: Colors.black,
            backgroundColor: context.colors.white,
            surfaceTintColor: context.colors.white,
            title: AppBarWidget(
              title: mode == Mode.view
                  ? AppLocalizations.of(context)!.viewing
                  : AppLocalizations.of(context)!.editing,
              actions: (context.watch<UserBloc>().state.userModel?.role == UserRole.keeper) ? [
                  if (mode == Mode.view) IconButton(
                      onPressed: () {
                        setState(() {
                          mode = Mode.edit;
                        });
                      },
                      icon: Icon(
                        Icons.edit,
                        color: context.colors.primary,
                      ),
                    ) else IconButton(
                      onPressed: () {
                        if (widget.book != null) {
                        context.read<BookBloc>().add(OnUpdateBook(
                          bookModel: widget.book!.copyWith(
                            name: nameController.text,
                            authorName: authorController.text,
                            publicationYear: int.tryParse(publicationYearController.text) ?? 0,
                            publisher: publisherController.text,
                            genre: genreController.text,
                            isbn: isbnController.text,
                            pagesCount: int.tryParse(pagesCountController.text) ?? 0,
                            booksCount: int.tryParse(booksCountController.text) ?? 0,
                            price: double.tryParse(priceController.text.replaceAll(',', '.')) ?? 0.0,
                            weight: int.tryParse(weightController.text) ?? 0,
                            location: locationController.text,
                          ),
                        ),); } else {
                          context.read<BookBloc>().add(OnAddBook(
                            bookModel: BookModel(
                              name: nameController.text,
                              authorName: authorController.text,
                              publicationYear: int.tryParse(publicationYearController.text) ?? 0,
                              publisher: publisherController.text,
                              genre: genreController.text,
                              isbn: isbnController.text,
                              pagesCount: int.tryParse(pagesCountController.text) ?? 0,
                              booksCount: int.tryParse(booksCountController.text) ?? 0,
                              price: double.tryParse(priceController.text.replaceAll(',', '.')) ?? 0.0,
                              weight: int.tryParse(weightController.text) ?? 0,
                              location: locationController.text,
                              cover: Cover.jacket,
                            ),
                          ),);
                        }
                        setState(() {
                          mode = Mode.view;
                        });
                      },
                      icon: Icon(
                        Icons.check,
                        color: context.colors.primary,
                      ),
                    ),
              ] : [],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.name,
                    textController: nameController,
                    readOnly: readOnly,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.authorName,
                    textController: authorController,
                    readOnly: readOnly,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.year,
                    textController: publicationYearController,
                    readOnly: readOnly,
                    formatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.publisher,
                    textController: publisherController,
                    readOnly: readOnly,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.genre,
                    textController: genreController,
                    readOnly: readOnly,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.isbn,
                    textController: isbnController,
                    readOnly: readOnly,
                  ),
                  if (mode != Mode.view)
                    EnumSelectorWidget(
                      label: AppLocalizations.of(context)!.cover,
                      enums: Cover.values,
                      names: covers,
                    )
                  else
                    TextFieldWithLabelWidget(
                      label: AppLocalizations.of(context)!.cover,
                      textController: TextEditingController(
                        text: widget.book != null
                            ? covers[widget.book!.cover.index]
                            : null,
                      ),
                      readOnly: readOnly,
                    ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.pagesCount,
                    textController: pagesCountController,
                    readOnly: readOnly,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.booksCount,
                    textController: booksCountController,
                    readOnly: readOnly,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.price,
                    textController: priceController,
                    readOnly: readOnly,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.weight,
                    textController: weightController,
                    readOnly: readOnly,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.location,
                    textController: locationController,
                    readOnly: readOnly,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
