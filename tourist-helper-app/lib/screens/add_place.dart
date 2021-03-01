import 'dart:convert';
import 'dart:io';

import 'package:flutter_tourist_helper/screens/place_routes.dart';
import 'package:flutter_tourist_helper/screens/places_list.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../place.dart';
//import 'package:flutter_network/course/course.dart';

class AddPlace extends StatefulWidget {
  //static const routeName = 'PlaceUpdate';
   //final PlaceArgument args;
   
   static const routeName = 'PlaceAdd';
   final PlaceArgument args;
  
  AddPlace({this.args});
  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {



  createPlace(){
    const url = "http://10.6.154.21:3000/posts";
   http.post(
      url,
      body: json.encode({
        'title': "place.titleeeeee"
      }),
    );
    
  }


  //TextEditingController
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _places = {};

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _globalKey,
      // appBar: AppBar(
      //   backgroundColor: Colors.deepOrange,
      //   title: Text("Add New Course"),
      // ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 30.0, 8.0, 0),
        child: Form(
          key: _formKey,
          child: ListView(
            
            children: [
              
              Container(
                padding: EdgeInsets.fromLTRB(15, 10, 20, 0),
                child: TextFormField(
                     initialValue:
                         widget.args.edit ? widget.args.place.title : '',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter name of the place';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Name of the place'),
                    onSaved: (value) {
                      this._places["title"] = value;
                    }),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 0, 20, 15),
                child: TextFormField(
                     initialValue:
                         widget.args.edit ? widget.args.place.category : '',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter the Category';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Category of the place'),
                    onSaved: (value) {
                      this._places["category"] = value;
                    }),
              ),
              
              // TextFormField(
              //     // initialValue: widget.args.edit
              //     //     ? widget.args.course.ects.toString()
              //     //     : '',
              //     validator: (value) {
              //       if (value.isEmpty) {
              //         return 'Please enter course ects';
              //       }
              //       return null;
              //     },
              //     decoration: InputDecoration(labelText: 'Course Image'),
              //     onSaved: (value) {
              //       setState(() {
              //         this._course["image"] = value;
              //       });
              //     }),
              Container(
              
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10) ,
                border: Border.all(
                  width: 1.5,
                  color: Colors.deepOrange.withOpacity(0.2)
                ),
              ),
              child: TextFormField(
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
                onSaved: (value) {
                    setState(() {
                      this._places["description"] = value;
                    });
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: imageplaceholder(),
            ),
            buttons(),
            
           
            ],
          ),
        ),
      ),
    );
  }


  Widget buttons(){
    
            return Row(
              children: [
                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FlatButton(
                    color: Colors.deepOrange,
                    onPressed: (){
                      _showModalNavigation();
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                   child: Row(
                     children: [
                       Text(
                         "Add Image",
                         style: TextStyle(
                           color: Colors.white,
                         ),
                       ),
                       SizedBox(width: 10),
                       Icon(
                         Icons.image,
                         color: Colors.white,
                       ),
                     ],
                   ),
                  ),
                                  ),
                ),
                Expanded(
                                  child: FlatButton(
                    color: Colors.deepOrange,
                    onPressed: (){
                      final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      final PlaceEvent event = widget.args.edit ?
                      PlaceUpdate(Place(
                        id:widget.args.place.id,
                        title: this._places["title"],
                        description: this._places["description"],
                        category: this._places["category"]
                      )):
                       PlaceCreate(
                              Place(
                                image: this._places["image"],
                                title: this._places["title"],
                                id: this._places["id"],
                                description: this._places["description"],
                                rating: this._places["rating"],
                                category: this._places["category"],
                                date: this._places["date"]
                              ),
                            );
                    
                      BlocProvider.of<PlaceBloc>(context).add(event);
                      //_globalKey.currentState.showSnackBar(SnackBar(content: Text("Updated Succesfully"),));
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=>PlacesList()));
                      BlocProvider.of<PlaceBloc>(context).add(PlaceLoad());

                     } // _post();
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                   child: Padding(
                     padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                     child: Row(
                       children: [
                         Text(
                           "Create Post",
                           style: TextStyle(
                             color: Colors.white,
                           ),
                         ),
                         SizedBox(width: 10),
                         Icon(
                           Icons.send,
                           color: Colors.white,
                         ),
                       ],
                     ),
                   ),
                  ),
                )
              ],
            );
    
  }

  File _image;
  _showModalNavigation(){
    showModalBottomSheet(context: context, builder: (BuildContext ctx){
      return Container(
        child: ListTile(
          leading: Icon(Icons.image),
          title: Text("Gallery"),
          onTap: () async {
            print("heyyyyyyyyyyyyyyyyyyyyy");
            //File image = await ImagePicker.pickImage(source: ImageSource.gallery);
             File image = await ImagePicker.pickImage(source: ImageSource.gallery,
             maxHeight: 400,
             maxWidth: 400,
            
             );
            print(image.toString()+ "testtttttttttttttttttttttttttttttttttttttttttttt");
            setState(() {
              _image = image;
            });
            Navigator.pop(context);
          },

        ),
      );
    });
  }

  Widget imageplaceholder(){
    return _image == null ? Container():Stack(
              children: [
                Container(
                  child: Image.file(_image,fit: BoxFit.cover,),
                  width: 200,
                  height: 200,
                ),
                Positioned(
                  top: 4.0,
                  right: 4.0,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: (){
                      setState(() {
                        _image = null;
                      });
                    },
                  ),
                )
              ],
            );
  }
}