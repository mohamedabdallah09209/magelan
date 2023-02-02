// ignore_for_file: prefer_if_null_operators, unnecessary_null_comparison
import 'dart:convert';
import 'package:magelan/conistants/basic_url.dart';
import 'package:http/http.dart' as http;
import 'package:magelan/models/slide.dart';
import 'package:flutter/material.dart';

class Slieds with ChangeNotifier {
  String basicUrl = basicUrl1;
  List<Slide> _slideList = [];
  List<Slide> get slideList {
    return [..._slideList];
  }
Slide findSlideById(String id) {
    return _slideList.firstWhere((slide) => slide.id == id);
  }

 List<Slide> findNormalSlides() {
    return _slideList.where((slide) => slide.type == "0").toList();
  }
  List<Slide> findSlides() {
    return _slideList.where((slide) => slide.type == "1").toList();
  }
  Future<void> fetchSliedes() async {
    final url = Uri.parse('$basicUrl/users/ads');
    try {
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
     
      final List<Slide> loadedData = [];
      for (int i = 0; i < extractedData["data"].length; i++) {
        loadedData.add(
          Slide(
            id: extractedData["data"][i]["id"].toString(),
            title: extractedData["data"][i]["lable"],
            type: extractedData["data"][i]["type"].toString(),
            imageUrl: extractedData["data"][i]["image"],
            description: extractedData["data"][i]["description"],
          ),
        );
      }
      _slideList = loadedData;
      notifyListeners();
    } catch (error) {
      return;
    }
  }
}
