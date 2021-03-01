import 'package:flutter_tourist_helper/models/models.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';



class ChatDataProvider {
  final http.Client httpClient;
  final _baseUrl = 'http://10.6.198.159:3011/comments/do-comment';
  final url = 'http://10.6.198.159:3011/comments';
  ChatDataProvider({this.httpClient}) : assert(httpClient != null);
  Future<Chat> createChat(Chat chat) async{
     print("------------------------------------------------------------------iiiiii");
     print(chat.post_id);
    final response = await httpClient.post(
      _baseUrl,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
          
           'comment': chat.comment,
           'post_id': chat.post_id
     
      }),
    );

    print("chat.comment---------------------------");

    if (response.statusCode == 200) {
    return Chat.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to create place.');
  }
}

  
  Future<List<Chat>> getChats() async {
    final response = await httpClient.get(url);

    if (response.statusCode == 200){
      final chats = jsonDecode(response.body) as List;
      
      return chats.map((chat) => Chat.fromJson(chat)).toList();
      
    }else {
      throw Exception('Failed to load places.');
    }
  }
  Future<List<Chat>> getChatsbyId(String id) async {
    print(id);
  
    final response = await http.get('$url/$id');
    print(response.body);
    if (response.statusCode == 200){
      final chats = jsonDecode(response.body) as List;
      
      return chats.map((chat) => Chat.fromJson(chat)).toList();
      
    }else {

      throw Exception('Failed to load places.');
    }
  }
  

  

  Future<void> deleteChat(String id) async {
    
    final http.Response response = await httpClient.delete(
      '$url/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode !=204){
      throw Exception('Failed to delete place.');
    }
  }

  Future<void> updateChat(Chat chat) async {
    
    print('$url/${chat.id}');
    final http.Response response = await http.put(
      '$url/${chat.id}',
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'description': chat.comment,
        
      })
    );
    if (response.statusCode != 204){
      throw Exception('Failed to update place.');
    }
  }

}
