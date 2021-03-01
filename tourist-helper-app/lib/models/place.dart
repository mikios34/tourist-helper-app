import 'dart:io';

import 'package:equatable/equatable.dart';

class Place extends Equatable{
  Place(
    {this.title,
    this.id,
    this.image,
    this.description,
    this.date,
    this.rating,
    this.category,
    this.imagefile

    });
  final File imagefile;
  final String title;
  final String id;
  final String image;
  final String description;
  //data type
  final String date;
  final String rating;

  final String category;

  List<Object> get props => [title, id, image, description, date, rating, category,imagefile];

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      title: json['title'],
      id: json['id'],
      image: json['image'],
      description: json['description'],
      date: json['date'],
      rating: json['rating'],
      category: json['category'],
      
    );

  }

  String toString() => 'Post { title: $title, id:$id, image:$image, description:$description, date:$date, rating:$rating, category:$category}';



}

