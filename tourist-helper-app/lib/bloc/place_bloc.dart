import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/place_repository.dart';
import 'bloc.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState>{
  
  final PlaceRepository placeRepository;

  PlaceBloc({@required this.placeRepository})
      : assert(placeRepository != null),
        super(PlaceLoading());

  @override
  Stream<PlaceState> mapEventToState(PlaceEvent event) async* {
    if (event is PlaceLoad) {
      yield PlaceLoading();
      try {
        final places = await placeRepository.getPlaces();
        yield PlacesLoadSuccess(places);
      } catch (_) {
        yield PlaceOperationFailure();
      }
    }

    if (event is PlaceCreate) {
      try {
        await placeRepository.createPlace(event.place);
        final places = await placeRepository.getPlaces();
        yield PlacesLoadSuccess(places);
      } catch (_) {
        yield PlaceOperationFailure();
      }
    }

    if (event is PlaceUpdate) {
      try {
        await placeRepository.updatePlace(event.place);
        final places = await placeRepository.getPlaces();
        yield PlacesLoadSuccess(places);
      } catch (_) {
        yield PlaceOperationFailure();
      }
    }

    if (event is PlaceDelete) {
      try {
        await placeRepository.deletePlace(event.place.id);
        final places = await placeRepository.getPlaces();
        yield PlacesLoadSuccess(places);
      } catch (_) {
        yield PlaceOperationFailure();
      }
    }
  }
}