import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/presentation.dart';
import 'package:sirius_books/features/books_collection/data/model/book_collection_model.dart';

class CollectionPage extends StatefulWidget {
  final CollectionModel collection;

  const CollectionPage({
    required this.collection,
    super.key,
  });

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late CollectionModel collection;
  @override
  void initState() {
    super.initState();
    collection = widget.collection;
  }

  @override
  Widget build(BuildContext context) {
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
                  actions: const [],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  collection.description,
                  style: context.textStyles.s14w400,
                ),
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
