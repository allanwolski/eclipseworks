import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import '../models/apod.dart';
import '../repositories/nasa_repository.dart';
import '../storage/nasa_storage.dart';

part 'nasa_event.dart';
part 'nasa_state.dart';

enum NasaStatus {
  initial,
  loading,
  loaded,
  error,
}

class NasaBloc extends Bloc<NasaEvent, NasaState> {
  final NasaStorage storage;
  final NasaRepository repository;

  NasaBloc({
    required this.storage,
    required this.repository,
  }) : super(NasaState()) {
    on<NasaEventInitialized>(_onInitializedEvent);
    on<NasaEventPictureRequested>(_onPictureRequestedEvent);
    on<NasaEventFavoriteChanged>(_onFavoriteChangedEvent);
    add(NasaEventInitialized());
  }

  Future<void> _onInitializedEvent(
    NasaEventInitialized event,
    Emitter<NasaState> emit,
  ) async {
    var favorites = await storage.retrieveFavorites();
    favorites.sort((a, b) => a.date.compareTo(b.date));
    emit(state.copyWith(favorites: favorites));
  }

  Future<void> _onPictureRequestedEvent(
    NasaEventPictureRequested event,
    Emitter<NasaState> emit,
  ) async {
    try {
      emit(state.copyWith(
        date: event.date,
        status: NasaStatus.loading,
      ));

      var apod = state.favorites.firstWhereOrNull((e) => e.date == event.date);
      apod ??= await repository.getAstronomyPictureOfDay(
        date: state.date,
      );

      emit(state.copyWith(
        apod: apod,
        status: NasaStatus.loaded,
      ));
    } on Exception {
      emit(state.copyWith(status: NasaStatus.error));
    }
  }

  Future<void> _onFavoriteChangedEvent(
    NasaEventFavoriteChanged event,
    Emitter<NasaState> emit,
  ) async {
    final favorites = List<Apod>.from(state.favorites);
    if (favorites.contains(event.apod)) {
      favorites.remove(event.apod);
    } else {
      favorites.add(event.apod);
    }

    storage.storeFavorites(favorites);
    favorites.sort((a, b) => a.date.compareTo(b.date));
    emit(state.copyWith(favorites: favorites));
  }
}
