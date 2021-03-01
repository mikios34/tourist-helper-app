import 'package:flutter_tourist_helper/data_provider/data_provider.dart';

import '../place.dart';


class PlaceRepository {
  final PlaceDataProvider dataProvider;

  PlaceRepository({this.dataProvider}): 
      assert(dataProvider != null);

  Future<Place> createPlace(Place place) async {
    return await dataProvider.createPlace(place);
  }

  Future<List<Place>> getPlaces() async{
    return await dataProvider.getPlace();
  }

  Future<void> updatePlace(Place place) async {
    await dataProvider.updatePlace(place);
  }

  Future<void> deletePlace(String id) async {
    await dataProvider.deletePlace(id);
  }
}

