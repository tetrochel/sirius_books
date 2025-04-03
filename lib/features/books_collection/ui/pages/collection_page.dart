import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/books_collection/data/model/book_collection_model.dart';
import 'package:sirius_books/features/utils/enums.dart';
import 'package:sirius_books/generated/app_localizations.dart';

class CollectionPage extends StatefulWidget {
  final Mode mode;
  final CollectionModel collection;

  const CollectionPage({
    required this.collection,
    required this.mode,
    super.key,
  });

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late Mode mode;
  late CollectionModel collection;
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    mode = widget.mode;
    collection = widget.collection;
    nameController = TextEditingController(text: collection.name);
    descriptionController = TextEditingController(text: collection.description);
  }

  @override
  Widget build(BuildContext context) {
    final readOnly = mode == Mode.view;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverAppBar(
                titleSpacing: 0,
                pinned: true,
                shadowColor: Colors.black,
                backgroundColor: context.colors.white,
                surfaceTintColor: context.colors.white,
                title: AppBarWidget(
                  title: collection.name,
                  actions: [
                    if (mode == Mode.view)
                      IconButton(
                        onPressed: () {
                          setState(() {
                            mode = Mode.edit;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: context.colors.primary,
                        ),
                      )
                    else
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.check,
                          color: context.colors.primary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.name,
                    textController: nameController,
                    readOnly: readOnly,
                  ),
                  TextFieldWithLabelWidget(
                    label: AppLocalizations.of(context)!.description,
                    textController: descriptionController,
                    readOnly: readOnly,
                    textInputType: TextInputType.multiline,
                  ),
                ]),
              ),
            ),
            SliverList.builder(
              itemBuilder: (context, index) => BookWidget(
                name: collection.books[index].name,
                authorName: collection.books[index].authorName,
                genre: collection.books[index].genre,
                onTap: () {
                  context.push(
                    '/books/details',
                    extra: collection.books[index],
                  );
                },
                onTapBookmark: () {},
              ),
              itemCount: collection.books.length,
            ),
          ],
        ),
      ),
    );
  }
}
