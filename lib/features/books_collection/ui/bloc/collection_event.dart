import 'package:sirius_books/features/books_collection/data/model/book_collection_model.dart';

sealed class CollectionEvent {}

class OnLoadCollections extends CollectionEvent {}

class OnAddCollection extends CollectionEvent {
  final CollectionModel collectionModel;

  OnAddCollection({
    required this.collectionModel,
  });
}

class OnReselCollectionList extends CollectionEvent {}
