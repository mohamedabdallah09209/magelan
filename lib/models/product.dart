import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:magelan/conistants/basic_url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Product with ChangeNotifier {
   String? id;
   String? name;
   String? storeName;
    String? store;
   String? storeNumber;
   String? description;
   String? price;
   String? imageUrl;
   String? discountPrice;
   
  bool? isFavorite;

  Product({
     this.id,
     this.name,
     this.storeName,
     this.store,
    
      this.storeNumber,
     this.description,
     this.discountPrice,
     this.price,
     this.imageUrl,
    this.isFavorite,
  });

 void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite!;
    notifyListeners();
     final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> extractedUserData =
        jsonDecode(prefs.getString("userData").toString())
            as Map<String, dynamic>;
    String token1 = extractedUserData['token'].toString();
    final url = Uri.parse('$basicUrl1/users/toggle-fav');

    try {
      final response = await http.post(url, body: {
        "productId":id,
      }, headers: {
        "Authorization": "Bearer $token1",
        "Accept": "application/json",
      });
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus!);
      }

    } catch (error) {
      _setFavValue(oldStatus!);
    }
  }
}
