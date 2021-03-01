import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tourist_helper/models/models.dart';
import 'package:flutter_tourist_helper/screens/add_place.dart';
import 'package:flutter_tourist_helper/screens/comment_screen/chat_screen.dart';
import 'package:flutter_tourist_helper/screens/comment_screen/update_chat.dart';
import 'package:flutter_tourist_helper/screens/place_detail.dart';
//import 'package:flutter_network/course/course.dart';
import 'package:flutter_tourist_helper/screens/places_list.dart';
import 'package:flutter_tourist_helper/screens/update_place.dart';
import 'package:flutter_tourist_helper/screens/user_screens/login.dart';
import 'package:flutter_tourist_helper/screens/user_screens/signup.dart';

class PlaceRout {
  static final storage = new FlutterSecureStorage();
   static checktoken() async {
    String value = await storage.read(key: 'token');
    return value;
  }
  
  static Route generateRoute(RouteSettings settings) {
    // gettoken()async {
    //   String value = await storage.read(key: 'token');
    //   //return value;
    // };
    // if (settings.name == '/') {
    //   return MaterialPageRoute(builder: (context) => PlacesList() );
    // }
    
    if (settings.name == AddPlace.routeName) {
      PlaceArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddPlace(
                args: args,
              ));
    }
    if (settings.name == UpdatePlace.routeName) {
      PlaceArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => UpdatePlace(
                args: args,
              ));
    }

    if (settings.name == PlaceDetail.routeName) {
      Place course = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => PlaceDetail(
                place: course,
              ));
    }
    if (settings.name == SignUp.routeName) {
      //User user = settings.arguments;
      return MaterialPageRoute(
        builder: (context)=> SignUp()
      );
      

    }
    if (settings.name == PlacesList.routeName) {
      //User user = settings.arguments;
      return MaterialPageRoute(
        builder: (context)=> PlacesList()
      );
      

    }

    if (settings.name == ChatScreen.routeName) {
      Place course = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => ChatScreen(
                place: course,
              ));
    }

    if (settings.name == UpdateChat.routeName) {
      ChatArgument args = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => UpdateChat(
                args: args,
              ));
    }

      
      return MaterialPageRoute(builder: (context) => LoginPage());
   
    
  }
}

class PlaceArgument {
  final Place place;
  final bool edit;
  PlaceArgument({this.place, this.edit});
}
class UserArgument{
  final User user;
  final bool edit;
  UserArgument({this.user,this.edit});
}
class ChatArgument{
  final Chat chat;
  final bool edit;
  ChatArgument({this.chat,this.edit});
}