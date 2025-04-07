part of 'nasa_bloc.dart';

abstract class NasaEvent extends Equatable {
  const NasaEvent();

  @override
  List<Object?> get props => [];
}

class NasaEventInitialized extends NasaEvent {}

class NasaEventPictureRequested extends NasaEvent {
  final DateTime? date;
  const NasaEventPictureRequested([this.date]);

  @override
  List<Object?> get props => [date];
}

class NasaEventFavoriteChanged extends NasaEvent {
  final Apod apod;
  const NasaEventFavoriteChanged(this.apod);

  @override
  List<Object?> get props => [apod];
}
