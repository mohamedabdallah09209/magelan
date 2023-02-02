import 'dart:convert';
import 'package:magelan/conistants/basic_url.dart';
import 'package:flutter/material.dart';
import 'package:magelan/models/http_exception.dart';
import 'package:magelan/models/store.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Stores with ChangeNotifier {
  String basicUrl = basicUrl1;
  bool success = false;
  List<Store> _stores = [];
  List<Store> get stores {
    return [..._stores];
  }

  List<Store> findStoreById(String id) {
    var stores = _stores
        .where((storeItem) => storeItem.category.toString() == id.toString())
        .toList();
    return stores;
  }

  Store findStore(String id) {
    return _stores
        .firstWhere((storeItem) => storeItem.id.toString() == id.toString());
  }

  Future<bool> estmate(
    String comment,
    double stars,
    String shop,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> extractedUserData =
        jsonDecode(prefs.getString("userData").toString())
            as Map<String, dynamic>;
    String token1 = extractedUserData['token'].toString();
    final url = Uri.parse('$basicUrl/users/rates');
    try {
      final response = await http.post(url, body: {
        "comment": comment,
        "stars": stars.toString(),
        "shop_id": shop
      }, headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token1",
      });
      final responseData = json.decode(response.body);
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      success = true;
      return success;
    } catch (error) {
    return success;
    }
  }

  Future<void> fetchStores() async {
    final url = Uri.parse('$basicUrl/users/shops');
    final url1 = Uri.parse('$basicUrl/users/get-suppliers');
    try {
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });

      final response1 = await http.get(url1, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      
      final List<Store> loadedData = [];
      final extractedData1 =
          json.decode(response1.body) as Map<String, dynamic>;
      for (int i = 0; i < extractedData["data"].length; i++) {
        for (int j = 0; j < extractedData1["data"].length; j++) {
          if (extractedData["data"][i]["user"]["id"].toString() ==
                  extractedData1["data"][j]["id"].toString() &&
              extractedData1["data"][j]["approved_status"].toString() == "1" &&
              extractedData1["data"][j]["activated_status"].toString() == "1") {
               
            loadedData.add(Store(
              id: extractedData["data"][i]["id"].toString(),
              name: extractedData["data"][i]["lable"].toString(),
              imageUrl: extractedData["data"][i]["image"].toString(),
              description: extractedData["data"][i]["description"].toString(),
              address: extractedData["data"][i]["address"].toString(),
              userId: extractedData["data"][i]["user"]["id"].toString(),
              category: extractedData["data"][i]["category"]["id"].toString(),
              rates: extractedData["data"][i]["rates"],
            ));
          }
        }
      }
      
      _stores = loadedData;
      notifyListeners();
    } catch (error) {
      return;
    }
  }
}
