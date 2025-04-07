part of 'nasa_bloc.dart';

class NasaState extends Equatable {
  final NasaStatus status;
  final Apod? apod;
  final DateTime? date;
  final List<Apod> favorites;

  const NasaState({
    this.status = NasaStatus.initial,
    this.apod,
    this.date,
    this.favorites = const [],
  });

  NasaState copyWith({
    final NasaStatus? status,
    final Apod? apod,
    final DateTime? date,
    final List<Apod>? favorites,
  }) {
    return NasaState(
      status: status ?? this.status,
      apod: apod ?? this.apod,
      date: date ?? this.date,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object?> get props => [
        status,
        apod,
        date,
        favorites,
      ];
}
