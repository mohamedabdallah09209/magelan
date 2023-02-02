
import 'package:flutter/material.dart';

class Category with ChangeNotifier{
  final String id;
  final String name;
  final String imageUrl;
  final List stores;
   Category( {
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.stores,
  });
  }
  
  