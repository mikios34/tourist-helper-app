import 'package:equatable/equatable.dart';

class User extends Equatable{

  User({
    this.email,
    this.id,
    this.password,
    this.name,this.phone,
    this.isAdmin
  });

  final String email;
  final String id;
  final String password;
  final String name;
  final String phone;
  final bool isAdmin;


  @override
  // TODO: implement props
  List<Object> get props => [email,id,password,name,phone,isAdmin];


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      id: json['id'],
      //image: json['image'],
      password: json['password'],
      name: json['name'],
      phone: json['phone'],
      //category: json['category'],
      
    );

  }
  String toString() => 'Post { name: $name, id:$id, email:$email, password:$password, phone:$phone, isAdmin:$isAdmin}';

}
