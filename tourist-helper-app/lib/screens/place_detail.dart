import 'package:flutter/material.dart';
import 'package:flutter_tourist_helper/bloc/bloc.dart';
import 'package:flutter_tourist_helper/models/models.dart';
import 'package:flutter_tourist_helper/screens/add_place.dart';
import 'package:flutter_tourist_helper/screens/place_routes.dart';

class PlaceDetail extends StatelessWidget {
  static const routeName = 'placeDetail';
  final Place place;

  PlaceDetail({@required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.place.title}'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => Navigator.of(context).pushNamed(
              AddPlace.routeName,
              arguments: PlaceArgument(place: this.place, edit: true),
            ),
          ),
          SizedBox(
            width: 32,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // context.read<PlaceBloc>().add(CourseDelete(this.place));
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     CoursesList.routeName, (route) => false);
              }),
        ],
      ),
      body: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Name: ${this.place.title}'),
              subtitle: Text('Category: ${this.place.category}'),
            ),
            Center(
              child: Text(
                'Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(this.place.description)
            ),
          ],
        ),
      ),
    );
  }
}