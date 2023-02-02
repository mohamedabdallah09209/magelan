import 'dart:convert';
import 'package:magelan/conistants/basic_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import 'package:flutter/material.dart';

class Products with ChangeNotifier {
  String basicUrl = basicUrl1;

  List<Product> _products = [];

  List<Product> get favoriteProducts {
    return _products.where((prodItem) => prodItem.isFavorite==true).toList();
  }

  List<Product> get products {
    return [..._products];
  }

  List<Product> findProductsByStoreId(String id) {
    return _products.where((product) => product.store == id).toList();
  }

  Product findProductById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchProducs() async {
    String userId="0";
    String token1="";
     final prefs = await SharedPreferences.getInstance();
         if (!prefs.containsKey('userData')) {}else{
    Map<String, dynamic> extractedUserData =
        jsonDecode(prefs.getString("userData").toString())
            as Map<String, dynamic>;
     token1 = extractedUserData['token'].toString();
     userId = extractedUserData['userId'].toString();
         }

    try {
        final url1 = Uri.parse('$basicUrl/users/profile/$userId');
       final response1 = await http.get(url1, headers: {
        "Authorization": "Bearer $token1",
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      final extractedData1 = json.decode(response1.body) as Map<String, dynamic>;

    final url = Uri.parse('$basicUrl/users/products');
      final response = await http.get(url, headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      
      final List<Product> loadedData = [];
      bool fav = false;
      for (int i = 0; i < extractedData["data"].length; i++) {
          if(prefs.containsKey('userData'))
          {
             for (int j = 0; j < extractedData1["data"]["favProducts"].length; j++) {
          if(extractedData["data"][i]["id"].toString()==extractedData1["data"]["favProducts"][j]["id"].toString()){
            fav=true;
          }
       }
          }

        loadedData.add(
          Product(
            id: extractedData["data"][i]["id"].toString(),
            name: extractedData["data"][i]["name"],
            imageUrl: extractedData["data"][i]["image"],
            description: extractedData["data"][i]["description"],
            discountPrice: extractedData["data"][i]["discountPrice"].toString(),
            price: extractedData["data"][i]["price"].toString(),
            storeName: extractedData["data"][i]["shop"]["lable"],
            storeNumber: extractedData["data"][i]["shop"]["user"]["phone_number"].toString(),
           
            // ignore: prefer_if_null_operators, unnecessary_null_comparison
            store: extractedData["data"][i]["shop"]["id"].toString() != null
                ? extractedData["data"][i]["shop"]["id"].toString()
                : "0",
            isFavorite: fav,
          ),
        );
        fav = false;
      }
      _products = loadedData;
      notifyListeners();
    } catch (error) {
      return;
    }
  }
}
