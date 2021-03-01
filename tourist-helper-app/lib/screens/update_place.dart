import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tourist_helper/bloc/bloc.dart';
import 'package:flutter_tourist_helper/bloc/place_event.dart';
import 'package:flutter_tourist_helper/models/place.dart';
import 'package:flutter_tourist_helper/screens/place_routes.dart';
import 'package:flutter_tourist_helper/screens/places_list.dart';


class UpdatePlace extends StatefulWidget {
  static const routeName = 'PlaceUpdate';
   final PlaceArgument args;
   UpdatePlace({this.args});
  @override
  _UpdatePlaceState createState() => _UpdatePlaceState();
}

class _UpdatePlaceState extends State<UpdatePlace> {
  TextEditingController desc;
  TextEditingController titl;
  TextEditingController categ;
  
  @override
  Widget build(BuildContext context) {
    desc = TextEditingController(text: widget.args.place.description);
    titl = TextEditingController(text: widget.args.place.title);
    categ = TextEditingController(text: widget.args.place.category);
    return Scaffold(
      
      body: ListView(
        padding: EdgeInsets.only(top: 40),
        children:[ Column(
          children: [
             Container(
               padding: EdgeInsets.fromLTRB(15, 0, 20, 15),
               child: TextField(
                controller: categ,
                decoration: InputDecoration(labelText: 'Category of the place'),
            ),
             ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 0, 20, 15),
              child: TextField(
                controller: titl,
                decoration: InputDecoration(labelText: 'Name of the place'),
              ),
            ),
           
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10) ,
                    border: Border.all(
                      width: 1.5,
                      color: Colors.deepOrange.withOpacity(0.2)
                    ),
                  ),
                  child: TextFormField(
                    controller: desc,
                    //controller: message,
                    maxLines: 5,
                    maxLength: 300,
                    validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter Place description';
                        }
                        return null;
                      },
                    
                    decoration: InputDecoration(
                      hintText: "Write here something about the place....",
                      border: InputBorder.none,

                    ),
                    
                  ),
                ),
            ),
            FlatButton(
              child: Text("Update"),
              onPressed: (){
                final chatEvent = PlaceUpdate(
                  Place(
                    id:widget.args.place.id,
                    description: desc.text,
                    title: titl.text
                  ),
                );
                BlocProvider.of<PlaceBloc>(context).add(chatEvent);
                Navigator.push(context,MaterialPageRoute(builder: (_)=>PlacesList()));
                BlocProvider.of<PlaceBloc>(context).add(PlaceLoad());
              },
            ),
          ],
        ),
        ]
      ),
      
    );
  }
}