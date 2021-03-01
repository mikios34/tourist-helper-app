import 'package:equatable/equatable.dart';

class Chat extends Equatable{
  Chat(
    {
      this.title,
      this.id,
      this.userid,
      this.comment,
      this.post_id
    }
  );

  final String title;
  final String id;
  final String userid;
  final String comment;
  final String post_id;

  List<Object> get props => [title, id, userid, comment, post_id];

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      title: json['title'],
      id: json['id'],
      userid: json['userid'],
      comment: json['comment'],
      post_id: json['post_id'],
    );
  }
  String toString() => 'Chat {title: $title, id: $id, useid: $userid, description: $comment, image: $post_id}';
}

