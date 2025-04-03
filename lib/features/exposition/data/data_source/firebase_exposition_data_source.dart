import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sirius_books/features/book/data/model/book_model.dart';
import 'package:sirius_books/features/exposition/data/model/exposition_model.dart';

class FirebaseExpositionDataSource {
  Future<void> addExposition(ExpositionModel expositionModel) async {
    try {
      await FirebaseFirestore.instance.collection('expositions').add({
        'Название': expositionModel.name.toString(),
        'Тема': expositionModel.topic.toString(),
        'Список книг':
            expositionModel.books.map((book) => book.firebaseId).toList(),
        'Место проведения': expositionModel.location.toString(),
        'Дата начала': expositionModel.startDate.toString(),
        'Дата окончания': expositionModel.endDate.toString(),
      });
    } on Exception catch (_) {
      return;
    }
  }

  Future<List<ExpositionModel>> getExpositionList() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('expositions').get();

      final expositionModelList = <ExpositionModel>[];
      for (final doc in querySnapshot.docs) {
        final idString = doc.id;
        final bookIds = List<String>.from(doc.get('Список книг') as List);

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

        expositionModelList.add(
          ExpositionModel(
            id: int.parse(idString),
            topic: doc.get('Тема').toString(),
            name: doc.get('Название').toString(),
            books: bookList,
            location: doc.get('Место проведения').toString(),
            startDate: DateTime.parse(doc.get('Дата начала').toString()),
            endDate: DateTime.parse(doc.get('Дата окончания').toString()),
          ),
        );
      }

      return expositionModelList;
    } on Exception catch (_) {
      return [];
    }
  }
}
