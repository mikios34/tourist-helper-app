//import 'dart:js';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tourist_helper/screens/comment_screen/chat_screen.dart';


import 'package:flutter_tourist_helper/screens/place_detail.dart';
import 'package:flutter_tourist_helper/screens/place_routes.dart';
import 'package:flutter_tourist_helper/screens/update_place.dart';
import '../bloc/bloc.dart';
import 'add_place.dart';
import '../models/place.dart';

class PlacesList extends StatelessWidget {
  static const routeName = '/placelist';
  //final UserArgument args;
  //SignUp({this.args});

   final storage = new FlutterSecureStorage();
     checktoken() async {
    String value = await storage.read(key: 'token');
    print(value);
    //return value;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Center(child: Text('List of Places')),
      ),
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (_, state) {
          //checktoken();
          if (state is PlaceOperationFailure) {
            return Center(
              child: Column(
                children: [
                  FlatButton(
                    child: Row(
                      children: [
                        Icon(
                          Icons.refresh,
                          color: Colors.black,
                        ),
                        Text(
                          "Refresh",
                          style: TextStyle(
                              fontWeight: FontWeight.w200, color: Colors.black),
                        )
                      ],
                    ),
                    onPressed: () {
                      BlocProvider.of<PlaceBloc>(context).add(PlaceLoad());
                      return CircularProgressIndicator();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: Text(
                      'Network Error Try Refresh',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is PlacesLoadSuccess) {
            print(
                '---------------------fas-dfas-dfa-sd-f-------------fasd-fa-sdf-asd-fas--------');
            final places = state.places;
            //print(places[0].image);

            return ListView.builder(
              itemCount: places.length,
              itemBuilder: (_, idx) => Card(
                child: makeCards(places, idx, context),
              ),
             
            );
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () => Navigator.of(context).pushNamed(
          AddPlace.routeName,
          arguments: PlaceArgument(edit: false),
        ),
        child: Icon(Icons.add),
      
      ),
    );
  }

  Widget makeCards(List<Place> places, int id, BuildContext ctx) {
    PageController pageController;
  
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: 300,
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                  image: NetworkImage('${places[id].image}'),
                )),
          ),
          Positioned(
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
            child: Container(
              padding: EdgeInsets.all(12.0),
              height: 110.0,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    //"miki",
                    '${places[id].title}',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w300,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.deepPurple,
                            ),
                            onPressed: () {
                              Navigator.of(ctx).pushNamed(UpdatePlace.routeName,
                                  arguments: PlaceArgument(
                                      place: places[id], edit: true));
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              //Navigator.
                              ctx
                                  .read<PlaceBloc>()
                                  .add(PlaceDelete(places[id]));
                              BlocProvider.of<PlaceBloc>(ctx).add(PlaceLoad());
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.comment,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(ctx,ChatScreen.routeName, arguments: places[id]);
                              // ctx
                              //     .read<PlaceBloc>()
                              //     .add(PlaceDelete(places[id]));
                              // BlocProvider.of<PlaceBloc>(ctx).add(PlaceLoad());
                            },
                          ),
                          SizedBox(width: 6.0),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(ctx).pushNamed(PlaceDetail.routeName,
                                  arguments: places[id]);
                            },
                            child: Text(
                              "Details >",
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
        //  ),
      ),
    );
  }
}
