import 'package:sirius_books/features/exposition/data/data_source/firebase_exposition_data_source.dart';
import 'package:sirius_books/features/exposition/data/model/exposition_model.dart';
import 'package:sirius_books/features/exposition/repository/exposition_repository.dart';

class ExpositionRepositoryImpl implements ExpositionRepository {
  FirebaseExpositionDataSource firebaseExpositionDataSource;

  ExpositionRepositoryImpl({required this.firebaseExpositionDataSource,});

  @override
  Future<List<ExpositionModel>> getAllExposition() async {
    return firebaseExpositionDataSource.getExpositionList();
  }

  @override
  Future<void> addExposition(ExpositionModel expositionModel) async {
    await firebaseExpositionDataSource.addExposition(expositionModel);
  }
}