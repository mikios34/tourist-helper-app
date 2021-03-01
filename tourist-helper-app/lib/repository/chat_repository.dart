import 'package:flutter_tourist_helper/data_provider/data_provider.dart';
import 'package:flutter_tourist_helper/models/models.dart';



class ChatRepository {
  final ChatDataProvider dataProvider;

  ChatRepository({this.dataProvider}): 
      assert(dataProvider != null);

  Future<Chat> createChat(Chat chat) async {
    return await dataProvider.createChat(chat);
  }

  Future<List<Chat>> getChats() async{
    return await dataProvider.getChats();
  }
   Future<List<Chat>> getChatsbyId(String id) async{
    return await dataProvider.getChatsbyId(id);
  }

  Future<void> updateChat(Chat chat) async {
    await dataProvider.updateChat(chat);
  }

  Future<void> deleteChat(String id) async {
    await dataProvider.deleteChat(id);
  }
}



