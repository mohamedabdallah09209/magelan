import 'package:flutter/material.dart';

class Store with ChangeNotifier{
  final String id;
   String? name;
   String? category;
  final String description;
  final String userId;
   String? address;
   List? rates;
  final String imageUrl;

   Store({
    required this.userId,
     this.address, 
    required this.imageUrl, 
    required this.id,
     this.rates,
     this.name,
     this.category,
    required this.description,
  });
  }