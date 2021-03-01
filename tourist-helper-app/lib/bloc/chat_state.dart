import 'package:equatable/equatable.dart';
import 'package:flutter_tourist_helper/models/models.dart';


class ChatState extends Equatable {
  const ChatState();

  List<Object> get props => [];
}

class ChatLoading extends ChatState {}

class ChatsLoadSuccess extends ChatState {
  final List<Chat> chats;

  ChatsLoadSuccess([this.chats = const []]);

  @override
  List<Object> get props => [chats];
}

class ChatOperationFailure extends ChatState {}











