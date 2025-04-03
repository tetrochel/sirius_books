import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirius_books/features/exposition/repository/exposition_repository.dart';
import 'package:sirius_books/features/exposition/ui/bloc/exposition_event.dart';
import 'package:sirius_books/features/exposition/ui/bloc/exposition_state.dart';

class ExpositionBloc extends Bloc<ExpositionEvent, ExpositionState> {
  final ExpositionRepository expositionRepository;

  ExpositionBloc({
    required this.expositionRepository,
  }) : super(ExpositionState()) {
    on<ExpositionEvent>((event, emit) async {
      switch (event) {
        case OnLoadExposition():
          await _handleOnLoadExposition(event, emit);
        case OnAddExpositionPressed():
          await _handleOnAddExpositionPressed(event, emit);
        case OnUpdateExpositionPressed():
          await _handleOnUpdateExpositionPressed(event, emit);
      }
    });
  }

  Future<void> _handleOnLoadExposition(
    OnLoadExposition event,
    Emitter<ExpositionState> emit,
  ) async {
    try {
      final expositionList = await expositionRepository.getAllExposition();
      emit(ExpositionState()..expositionModelList = expositionList);
        } on Exception catch (_) {
      return;
    }
  }

  Future<void> _handleOnAddExpositionPressed(
    OnAddExpositionPressed event,
    Emitter<ExpositionState> emit,
  ) async {
    try {
      await expositionRepository.addExposition(event.expositionModel);
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> _handleOnUpdateExpositionPressed(
    OnUpdateExpositionPressed event,
    Emitter<ExpositionState> emit,
  ) async {
    try {
      await expositionRepository.updateExposition(event.expositionModel);
    } on Exception catch (_) {
      return;
    }
  }
}
