import 'package:flutter/cupertino.dart';

class Album {
  final String name;
  final String author;
  final String description;
  final DateTime relatedDate;
  final Duration length;
  final ImageProvider coverImage;

  const Album({
    required this.name,
    required this.author,
    required this.description,
    required this.relatedDate,
    required this.length,
    required this.coverImage,
  });
}
