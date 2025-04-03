import 'package:sirius_books/config/navigation/navigator_controller.dart';
import 'package:sirius_books/features/book/data/data_source/firebase_book_data_source.dart';
import 'package:sirius_books/features/book/repository/book_repository_impl.dart';
import 'package:sirius_books/features/books_collection/data/data_source/firebase_collection_data_source.dart';
import 'package:sirius_books/features/books_collection/repository/collection_repository_impl.dart';
import 'package:sirius_books/features/exposition/data/data_source/firebase_exposition_data_source.dart';
import 'package:sirius_books/features/exposition/repository/exposition_repository_impl.dart';
import 'package:sirius_books/features/user/data/data_source/firebase_user_data_source.dart';
import 'package:sirius_books/features/user/data/data_source/local_user_data_source.dart';
import 'package:sirius_books/features/user/repository/user_repository_impl.dart';
import 'package:sirius_books/features/user/ui/bloc/user_bloc.dart';
import 'package:yx_scope/yx_scope.dart';

class AppScopeContainer extends ScopeContainer {
  late final firebaseUserDataSourceDep = dep(FirebaseUserDataSource.new);
  late final localUserDataSourceDep = dep(LocalUserDataSource.new);
  late final userRepositoryDep = dep(
    () => UserRepositoryImpl(
      firebaseUserDataSource: firebaseUserDataSourceDep.get,
      localUserDataSource: localUserDataSourceDep.get,
    ),
  );
  late final navigationControllerDep = dep(NavigationController.new);
  late final userBlocDep = dep(
    () => UserBloc(
      userRepository: userRepositoryDep.get,
      navigationController: navigationControllerDep.get,
    ),
  );

  late final firebaseBookDataSourceDep = dep(FirebaseBookDataSource.new);
  late final bookRepositoryDep = dep(
    () => BookRepositoryImpl(
      firebaseBookDataSource: firebaseBookDataSourceDep.get,
    ),
  );

  late final firebaseExpositionDataSourceDep =
      dep(FirebaseExpositionDataSource.new);
  late final expositionRepositoryDep = dep(
    () => ExpositionRepositoryImpl(
      firebaseExpositionDataSource: firebaseExpositionDataSourceDep.get,
    ),
  );

  late final firebaseCollectionDataSourceDep =
      dep(FirebaseCollectionDataSource.new);
  late final collectionRepositoryDep = dep(
    () => CollectionRepositoryImpl(
      firebaseCollectionDataSource: firebaseCollectionDataSourceDep.get,
    ),
  );
}

class AppScopeHolder extends ScopeHolder<AppScopeContainer> {
  @override
  AppScopeContainer createContainer() => AppScopeContainer();
}
