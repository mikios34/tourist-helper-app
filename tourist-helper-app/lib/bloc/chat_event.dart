
import 'package:equatable/equatable.dart';
import 'package:flutter_tourist_helper/models/models.dart';


abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class ChatLoad extends ChatEvent {
  const ChatLoad();

  @override
  List<Object> get props => [];
}
class ChatLoadbyId extends ChatEvent {
  final Place place;

  
  const ChatLoadbyId(this.place);

  @override
  List<Object> get props => [];
}

class ChatCreate extends ChatEvent {
  final Chat chat;

  const ChatCreate(this.chat);

  @override
  List<Object> get props => [chat];

  @override
  String toString() => 'Chat Created {course: $chat}';
}

class ChatUpdate extends ChatEvent {
  //print("twssssssssssssssssssssss");
  final Chat chat;

  const ChatUpdate(this.chat);

  @override
  List<Object> get props => [chat];

  @override
  String toString() => 'Course Updated {course: $chat}';
}

class ChatDelete extends ChatEvent {
  final Chat chat;

  const ChatDelete(this.chat);

  @override
  List<Object> get props => [chat];

  @override
  toString() => 'Course Deleted {course: $chat}';
}



