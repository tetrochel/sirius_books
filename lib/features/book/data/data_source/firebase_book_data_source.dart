import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';

class FirebaseBookDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addBookToCollection(
    BookModel bookModel,
    String collectionModelId,
  ) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) return;

      final collectionDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('collections')
          .doc(collectionModelId)
          .get();

      if (!collectionDoc.exists) return;

      final currentBookIds = List.from(collectionDoc.data()?['Список книг'] ?? []);

      if (bookModel.firebaseId != null && !currentBookIds.contains(bookModel.firebaseId)) {
        currentBookIds.add(bookModel.firebaseId);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .collection('collections')
            .doc(collectionModelId)
            .update({
          'Список книг': currentBookIds,
        });
      }
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> addBook(BookModel bookModel) async {
    try {
      await FirebaseFirestore.instance.collection('myCollection').add({
        'Наименование': bookModel.name.toString(),
        'Автор': bookModel.authorName.toString(),
        'Год': bookModel.publicationYear.toString(),
        'Изд-во': bookModel.publisher.toString(),
        'ISBN': bookModel.isbn.toString(),
        'Переплет': _convertCoverToString(bookModel.cover).toString(),
        'Страниц': bookModel.pagesCount.toString(),
        'Количество': bookModel.booksCount.toString(),
        'Стоимсоть': bookModel.price.toString(),
        'Вес': (bookModel.weight * 100).toString(),
        'Жанр': bookModel.genre.toString(),
        'Место': bookModel.location.toString(),
      });
    } on Exception catch (_) {
      return;
    }
  }

  Future<List<BookModel>?> getBookList() async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('myCollection').get();

      final bookModelList = <BookModel>[];
      for (final doc in querySnapshot.docs) {
        bookModelList.add(
          BookModel.fromFirebase(doc.id, doc.data() as Map<String, dynamic>),
        );
      }

      return bookModelList;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<void> updateBook(BookModel bookModel) async {
    try {
      if (bookModel.firebaseId == null) return;

      await FirebaseFirestore.instance.collection('myCollection').doc(bookModel.firebaseId).update({
        'Наименование': bookModel.name.toString(),
        'Автор': bookModel.authorName.toString(),
        'Год': bookModel.publicationYear.toString(),
        'Изд-во': bookModel.publisher.toString(),
        'ISBN': bookModel.isbn.toString(),
        'Переплет': _convertCoverToString(bookModel.cover).toString(),
        'Страниц': bookModel.pagesCount.toString(),
        'Количество': bookModel.booksCount.toString(),
        'Стоимсоть': bookModel.price.toString(),
        'Вес': (bookModel.weight * 100).toString(),
        'Жанр': bookModel.genre.toString(),
        'Место': bookModel.location.toString(),
      });
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> removeBookFromCollection(
    BookModel bookModel,
    String collectionModelId,
  ) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser == null) return;

      final collectionDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .collection('collections')
          .doc(collectionModelId)
          .get();

      if (!collectionDoc.exists) return;

      final currentBookIds = List.from(collectionDoc.data()?['Список книг'] ?? []);

      if (bookModel.firebaseId != null) {
        currentBookIds.remove(bookModel.firebaseId);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .collection('collections')
            .doc(collectionModelId)
            .update({
          'Список книг': currentBookIds,
        });
      }
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> deleteBook(BookModel bookModel) async {
    try {
      if (bookModel.firebaseId == null) return;

      await FirebaseFirestore.instance.collection('myCollection').doc(bookModel.firebaseId).delete();
    } on Exception catch (_) {
      return;
    }
  }

  String _convertCoverToString(Cover cover) {
    switch (cover) {
      case Cover.hard:
        return 'в пер';
      case Cover.jacket:
        return 'в пер., супер.';
      case Cover.soft:
        return 'мягкий';
    }
  }
}
