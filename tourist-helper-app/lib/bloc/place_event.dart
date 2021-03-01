import 'package:equatable/equatable.dart';


import '../place.dart';
import '../place.dart';

abstract class PlaceEvent extends Equatable{
  const PlaceEvent();
}

class PlaceLoad extends PlaceEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PlaceCreate extends PlaceEvent {
  final Place place;

  const PlaceCreate(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'Place Created {place: $place}';
}

class PlaceUpdate extends PlaceEvent {
  final Place place;

  const PlaceUpdate(this.place);

  @override
  List<Object> get props => [place];

  @override
  String toString() => 'Place Updated {place: $place}';
}

class PlaceDelete extends PlaceEvent {
  final Place place;

  const PlaceDelete(this.place);

  @override
  List<Object> get props => [place];

  @override
  toString() => 'Place Deleted {Place: $place}';
}
