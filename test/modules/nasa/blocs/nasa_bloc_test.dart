import 'package:bloc_test/bloc_test.dart';
import 'package:eclipseworks/modules/nasa/blocs/nasa_bloc.dart';
import 'package:eclipseworks/modules/nasa/repositories/nasa_repository.dart';
import 'package:eclipseworks/modules/nasa/storage/nasa_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../models/apod_mock.dart';
import '../repositories/nasa_repository_mock.dart';
import '../storage/nasa_storage_mock.dart';

void main() {
  late NasaBloc bloc;
  late NasaStorage storage;
  late NasaRepository repository;

  setUp(() {
    storage = NasaStorageMock();
    repository = NasaRepositoryMock();
    bloc = NasaBloc(
      storage: storage,
      repository: repository,
    );

    when(() => storage.retrieveFavorites()).thenAnswer((_) async => []);
  });

  blocTest(
    'Should emit NasaStatus.loaded when a new image request succeeds',
    build: () => bloc,
    setUp: () {
      when(() => repository.getAstronomyPictureOfDay()).thenAnswer((_) async => apodMock);
    },
    act: (NasaBloc bloc) => bloc.add(
      NasaEventPictureRequested(),
    ),
    expect: () => [
      NasaState(status: NasaStatus.loading),
      NasaState(status: NasaStatus.loaded, apod: apodMock),
    ],
  );

  blocTest(
    'Should emit NasaStatus.error when a new image request fails',
    build: () => bloc,
    setUp: () {
      when(() => repository.getAstronomyPictureOfDay()).thenThrow((_) => Exception());
    },
    act: (NasaBloc bloc) => bloc.add(
      NasaEventPictureRequested(),
    ),
    expect: () => [
      NasaState(status: NasaStatus.loading),
      NasaState(status: NasaStatus.error),
    ],
  );

  blocTest(
    'Should update state when an image is saved to favorites',
    build: () => bloc,
    setUp: () {
      when(() => storage.storeFavorites(any())).thenAnswer((_) => Future.value());
    },
    act: (NasaBloc bloc) => bloc.add(
      NasaEventFavoriteChanged(apodMock),
    ),
    expect: () => [
      NasaState(favorites: [apodMock]),
    ],
  );
}
