import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tourist_helper/bloc/bloc.dart';
import 'package:flutter_tourist_helper/models/models.dart';
import 'package:flutter_tourist_helper/screens/place_routes.dart';


class UpdateChat extends StatefulWidget {
  static const routeName = '/updatechat';
   final ChatArgument args;
   UpdateChat({this.args});
  @override
  _UpdateChatState createState() => _UpdateChatState();
}

class _UpdateChatState extends State<UpdateChat> {
  TextEditingController desc;
  
  @override
  Widget build(BuildContext context) {
    desc = TextEditingController(text: widget.args.chat.comment);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
      ),
      body: Column(
        children: [
          TextField(
            controller: desc,
          ),
          FlatButton(
            child: Text("Update"),
            onPressed: (){
              final chatEvent = ChatUpdate(
                Chat(
                  id:widget.args.chat.id,
                  comment: desc.text,
                ),
              );
              BlocProvider.of<ChatBloc>(context).add(chatEvent);
              
              BlocProvider.of<ChatBloc>(context).add(ChatLoad());
            },
          ),
        ],
      ),
      
    );
  }
}