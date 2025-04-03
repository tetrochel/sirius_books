import 'package:sirius_books/features/exposition/data/model/exposition_model.dart';

abstract interface class ExpositionRepository {
  Future<List<ExpositionModel>> getAllExposition();

  Future<void> addExposition(ExpositionModel expositionModel);
}