import 'package:sirius_books/features/books_collection/data/model/book_collection_model.dart';

abstract interface class CollectionRepository {
  Future<List<CollectionModel>?> getCollections();

  Future<void> addCollection(CollectionModel collectionModel);
}