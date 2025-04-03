import 'package:sirius_books/features/books_collection/data/data_source/firebase_collection_data_source.dart';
import 'package:sirius_books/features/books_collection/data/model/book_collection_model.dart';
import 'package:sirius_books/features/books_collection/repository/collection_repository.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final FirebaseCollectionDataSource firebaseCollectionDataSource;

  CollectionRepositoryImpl({
    required this.firebaseCollectionDataSource,
  });

  @override
  Future<List<CollectionModel>?> getCollections() async {
    return firebaseCollectionDataSource.getAllCollections();
  }

  @override
  Future<void> addCollection(CollectionModel collectionModel) async {
    await firebaseCollectionDataSource.addCollection(collectionModel);
  }
}
