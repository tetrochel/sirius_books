import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/books_collection/data/model/book_collection_model.dart';

class FirebaseCollectionDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<CollectionModel>?> getAllCollections() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) return null;

      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('collections')
          .get();

      final collectionModelList = <CollectionModel>[];
      for (final doc in querySnapshot.docs) {
        final idString = doc.id;
        final bookIds = List<String>.from(doc.get('Список книг') as List);
        
        // Получаем список книг для коллекции
        final bookList = <BookModel>[];
        for (final bookId in bookIds) {
          final bookDoc = await FirebaseFirestore.instance
              .collection('myCollection')
              .doc(bookId)
              .get();
          
          if (bookDoc.exists) {
            bookList.add(BookModel.fromFirebase(bookId, bookDoc.data()!));
          }
        }

        collectionModelList.add(
          CollectionModel(
            firebaseId: idString,
            name: doc.get('Название').toString(),
            description: doc.get('Описание').toString(),
            books: bookList,
          ),
        );
      }

      return collectionModelList;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<void> addCollection(CollectionModel collectionModel) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) return;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('collections')
          .add({
        'Название': collectionModel.name.toString(),
        'Описание': collectionModel.description.toString(),
        'Список книг': collectionModel.books.map((book) => book.firebaseId).toList(),
      });
    } on Exception catch (_) {
      return;
    }
  }
}