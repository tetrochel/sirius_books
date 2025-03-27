Files structure overview:


di.dart - yx_scope container
config
    navigation.dart - routes and go_router
    theme.dart
    constants.dart
core
    utils/
    widgets/
features
    feature
        data/
            models/
            data_source/
        repository
            repository.dart
            repository_impl.dart
        ui
            bloc
                feature_bloc.dart
                featured_event.dart
                feature_state.dart
            pages/
            widgets/

// Отдельная библиотека со всеми виджетами
// Они полностью не зависят от логики, получая внутрь только нужные данные, а не объекты классов
presentation
    widgets/