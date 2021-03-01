import 'package:equatable/equatable.dart';
import 'package:flutter_tourist_helper/models/models.dart';

abstract class UserEvent extends Equatable{
  const UserEvent();
}

class UserLoad extends UserEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class UserCreate extends UserEvent {
  final User user;

  const UserCreate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Place Created {user: $user}';
}
class UserLogin extends UserEvent {
  final User user;

  const UserLogin(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Place Created {user: $user}';
}

class UserUpdate extends UserEvent {
  final User user;

  const UserUpdate(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Place Updated {user: $user}';
}

class UserDelete extends UserEvent {
  final User user;

  const UserDelete(this.user);

  @override
  List<Object> get props => [user];

  @override
  toString() => 'User Deleted {Place: $user}';
}
