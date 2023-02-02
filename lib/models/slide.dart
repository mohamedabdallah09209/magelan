import 'package:flutter/material.dart';

class Slide with ChangeNotifier{
  final String imageUrl;
  final String title;
  final String description;
  final String id;
  final String type;

  Slide({
required this.id,
required this.type,
    required this.imageUrl,
  required this.title,
    required this.description,
  });
}
