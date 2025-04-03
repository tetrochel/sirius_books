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
      }
    });
  }

  Future<void> _handleOnLoadExposition(
    OnLoadExposition event,
    Emitter<ExpositionState> emit,
  ) async {}

  Future<void> _handleOnAddExpositionPressed(
    OnAddExpositionPressed event,
    Emitter<ExpositionState> emit,
  ) async {}
}
