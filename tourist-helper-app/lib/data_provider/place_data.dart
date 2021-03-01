import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tourist_helper/models/place.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

class PlaceDataProvider {
  final _baseUrl = 'http://10.6.198.159:3011';
  final http.Client httpClient;
  final url = "http://10.6.198.159:3011/posts/";
  PlaceDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Place> createPlace(Place place) async {
    final response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode({
        'title': place.title,
        // 'image': place.image,
        'description': place.description,
        // 'rating': place.rating,
        'category': place.category,
        // 'date' : place.date
      }),
    );

    if (response.statusCode == 200) {
      print("yesssssssssssssssssssssssssssssssssss");
      return Place.fromJson(jsonDecode(response.body));
    } else {
      print(place.title);
      print(response.statusCode);
      print("nooooooooooooooooooooooooooooooooooooo");
      throw Exception('Failed to create place.');
    }
  }
  final storage = new FlutterSecureStorage();
  // void checktoken() async {
   
  //   print(value);
  //   //return value;
  // }

  Future<List<Place>> getPlace() async {
     String token = await storage.read(key: 'token');
     print(token);
    final response = await httpClient.get(

      '$_baseUrl/posts/',
      headers: {
        'Authorization': 'Bearer $token',
      },
      );
      //checktoken();

    if (response.statusCode == 200) {
      final places = jsonDecode(response.body) as List;
      return places.map((place) => Place.fromJson(place)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<void> deletePlace(String id) async {
    final http.Response response = await httpClient.delete(
      '$url/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete place.');
    }
  }

  Future<void> updatePlace(Place place) async {
    final http.Response response = await http.put(
      '$url/${place.id}',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'id': place.id,
        'title': place.title,
        'description': place.description,
        'catagory': place.category,

      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update place.');
    }
  }
}
