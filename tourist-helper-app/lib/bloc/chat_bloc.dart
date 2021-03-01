import 'package:flutter_tourist_helper/bloc/chat_event.dart';
import 'package:flutter_tourist_helper/bloc/chat_state.dart';
import 'package:flutter_tourist_helper/repository/repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';





class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc({this.chatRepository})
        :assert(chatRepository != null),
          super(ChatLoading());   
  
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatLoad) {
      yield ChatLoading();
      try {
        final chats = await chatRepository.getChats();
        yield ChatsLoadSuccess(chats);
      } catch (_) {
        yield ChatOperationFailure();
      }
    }

    if (event is ChatCreate) {
      try {
        await chatRepository.createChat(event.chat);
        final chats = await chatRepository.getChats();
        yield ChatsLoadSuccess(chats);
      } catch (_) {
        yield ChatOperationFailure();
      }
    }
    if(event is ChatLoadbyId){
      yield ChatLoading();
      try {
        final chats = await chatRepository.getChatsbyId(event.place.id);
        yield ChatsLoadSuccess(chats);
      } catch (_) {
        yield ChatOperationFailure();
      }

    }

if (event is ChatUpdate) {
      try {
        await chatRepository.updateChat(event.chat);
        final chats = await chatRepository.getChats();
        yield ChatsLoadSuccess(chats);
      } catch (_) {
        yield ChatOperationFailure();
      }
    }
if (event is ChatDelete) {
      try {
        await chatRepository.deleteChat(event.chat.id);
        final chats = await chatRepository.getChats();
        yield ChatsLoadSuccess(chats);
      } catch (_) {
        yield ChatOperationFailure();
      }
    }
  }
}







