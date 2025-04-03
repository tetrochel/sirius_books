import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';

class FirebaseBookDataSource {
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
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('myCollection')
          .limit(20)
          .get();

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
      
      await FirebaseFirestore.instance
          .collection('myCollection')
          .doc(bookModel.firebaseId)
          .update({
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
