import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sirius_books/features/books_collection/repository/collection_repository.dart';
import 'package:sirius_books/features/books_collection/ui/bloc/collection_event.dart';
import 'package:sirius_books/features/books_collection/ui/bloc/collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  final CollectionRepository collectionRepository;

  CollectionBloc({
    required this.collectionRepository,
  }) : super(CollectionState()) {
    on<CollectionEvent>((event, emit) async {
      switch (event) {
        case OnLoadCollections():
          await _handleLoadCollections(event, emit);
        case OnAddCollection():
          await _handleAddCollection(event, emit);
        case OnReselCollectionList():
          await _handleResetCollectionList(event, emit);
      }
    });
  }

  Future<void> _handleLoadCollections(
    OnLoadCollections event,
    Emitter<CollectionState> emit,
  ) async {
    try {
      final collectionList = await collectionRepository.getCollections();
      if (collectionList != null) {
        emit(CollectionState()..collectionList = collectionList);
      }
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> _handleAddCollection(
    OnAddCollection event,
    Emitter<CollectionState> emit,
  ) async {
    try {
      await collectionRepository.addCollection(event.collectionModel);
    } on Exception catch (_) {
      return;
    }
  }

  Future<void> _handleResetCollectionList(
    OnReselCollectionList event,
    Emitter<CollectionState> emit,
  ) async {
    emit(CollectionState()..collectionList = []);
  }
}
