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
          await _handleLoadCollections();
        case OnAddCollection():
          await _handleAddCollection();
      }
    });
  }

  Future<void> _handleLoadCollections() async {

  }

  Future<void> _handleAddCollection() async {}
}
