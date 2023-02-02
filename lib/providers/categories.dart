import 'dart:convert';
import 'package:magelan/conistants/basic_url.dart';
import 'package:magelan/models/category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Categories with ChangeNotifier {
  String basicUrl=basicUrl1;
   List<Category> _categories = [
  
  ];
  List<Category> get categories {
    return [..._categories];
  }
  Category findById(String id) {
    return _categories.firstWhere((category) => category.id==id);
  }
  
 Future<void> fetchCategories() async {
    final url = Uri.parse('$basicUrl/users/categories');
    try {
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      }); 
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Category> loadedData = [];
      for (int i = 0; i < extractedData["data"].length; i++) {
        loadedData.add(
          Category(
              id: extractedData["data"][i]["id"].toString(),
              name: extractedData["data"][i]["name"].toString(),
              imageUrl: extractedData["data"][i]["image"].toString(),
              stores: extractedData["data"][i]["shops"]),
        );
      }
      _categories = loadedData;
      notifyListeners();
    } catch (error) {
      return;
    }
  }
}
