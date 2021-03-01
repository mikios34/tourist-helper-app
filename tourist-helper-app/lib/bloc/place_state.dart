import 'package:equatable/equatable.dart';


import '../place.dart';

class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

class PlaceLoading extends PlaceState {}

class PlacesLoadSuccess extends PlaceState {
  final List<Place> places;

  PlacesLoadSuccess([this.places = const []]);

  @override
  List<Object> get props => [places];
}

class PlaceOperationFailure extends PlaceState {}
