import 'package:sirius_books/features/exposition/data/model/exposition_model.dart';

sealed class ExpositionEvent {}

class OnLoadExposition extends ExpositionEvent {}

class OnAddExpositionPressed extends ExpositionEvent {
  ExpositionModel expositionModel;

  OnAddExpositionPressed({
    required this.expositionModel,
  });
}

class OnUpdateExpositionPressed extends ExpositionEvent {
  ExpositionModel expositionModel;

  OnUpdateExpositionPressed({
    required this.expositionModel,
  });
}
