import 'dart:convert';
import 'package:magelan/conistants/basic_url.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:magelan/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _userId;
  String? _roleId;
  String? _name;
  String? _password;
  String? _userName;
  String? _userEmail;
  String? _imgUrl;
  String? _phone;
  bool success=false;
  String basicUrl = basicUrl1;

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_token != null) {
      return _token;
    }
    return null;
  }
  String? get roleId {
    return _roleId;
  }

  Future<bool> signup(String name, String email, String phone,
      String password) async {
    final url = Uri.parse('$basicUrl/auth/register');
    try {
      final response = await http.post(url, body: {
        "name": name,
        "email": email,
        "password": password,
        "phone_number": phone,
        "username": phone,
        "role_id": "2",
        "password_confirmation": password,
      },headers: { "Accept": "application/json",});
      final responseData = json.decode(response.body);
      
      if (responseData['data']['error'] != null) {
        throw HttpException(responseData['data']['error']);
      }
      success=true;
      _token = responseData['data']['token'].toString();
      _roleId = responseData['data']['user']['role_id'].toString();
      _userId = responseData['data']['user']['id'].toString();
      _password=password;
      _userName = "responseData['data']['user']['username'].toString()";
      _userEmail = responseData['data']['user']['email'].toString();
      _name = responseData['data']['user']['name'].toString();
      _imgUrl = responseData['data']['user']['avatar'].toString();
      _phone = responseData['data']['user']['phone_number'].toString();
      
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode(
        {
          'token': _token,
          'roleId': _roleId,
          'userId': _userId,
          'userName': _userName,
          'password':_password,
          'userEmail': _userEmail,
          'name': _name,
          'imgUrl': _imgUrl,
          'phone': _phone,
        },
      );
      prefs.setString('userData', userData);
      notifyListeners();
      return success;
    } catch (error) {
      throw HttpException(error.toString());
    }
  }

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$basicUrl/auth/login');
    try {
      final response = await http.post(url, body: {
        "email": email,
        "password": password,
      });
      final responseData = json.decode(response.body);
      if (responseData['data']['error'] != null) {
        throw HttpException(responseData['data']['error']);
      }
      success=true;
      _token = responseData['data']['token'].toString();
      _roleId = responseData['data']['user']['role_id'].toString();
      _userId = responseData['data']['user']['id'].toString();
      _password=password;
      _userName = "responseData['data']['user']['username'].toString()";
      _userEmail = responseData['data']['user']['email'].toString();
      _name = responseData['data']['user']['name'].toString();
      _imgUrl = responseData['data']['user']['avatar'].toString();
      _phone = responseData['data']['user']['phone_number'].toString();
    
      
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'roleId': _roleId,
          'userId': _userId,
          'userName': _userName,
          'password':_password,
          'userEmail': _userEmail,
          'name': _name,
          'imgUrl': _imgUrl,
          'phone': _phone,
        },
      );
      prefs.setString('userData', userData);
        
    } catch (error) {
      rethrow;
    }
    return success;
  }

  Future<bool> editProfile( String email,
      String phone,String password,name) async {
        final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> extractedUserData =
        jsonDecode(prefs.getString("userData").toString())
            as Map<String, dynamic>;
    String token1 = extractedUserData['token'].toString();
    String updateId = extractedUserData['userId'].toString();

    final url = Uri.parse('$basicUrl/users/update-profile/$updateId');
    try {
      final response = await http.post(url, body: {
        "_method":"put",
        "phone_number": phone,
        "name":name,
        "password":password,
        "password_confirmation":password,
      }, headers: {
        "Authorization": "Bearer $token1",
        "Accept": "application/json",
      });
      final responseData = json.decode(response.body);
  
      if (responseData['data']['error'] != null) {
        throw HttpException(responseData['data']['error']);
      }
      success = true;
      
      _userName = responseData['data']['username'].toString();
      _password = password;
      
      _userEmail = responseData['data']['email'].toString();
      _name = responseData['data']['name'].toString();
      _phone = responseData['data']['phone_number'].toString();
      
      final prefs = await SharedPreferences.getInstance();
          Map<String, dynamic> extractedUserData = jsonDecode(prefs.getString("userData").toString()) as Map<String, dynamic>;


      final userData = json.encode(
        {
          'token': extractedUserData['token'],
          'roleId': extractedUserData['roleId'],
          'userId': extractedUserData['userId'],
          'userName': _userName,
          'userEmail': _userEmail,
          'password':_password,
          'name': _name,
          'imgUrl': extractedUserData['imgUrl'],
          'phone': _phone,
        },
      );
      prefs.clear();
      prefs.setString('userData', userData);
       notifyListeners();
      return success;
    } catch (error) {
      rethrow ;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
  
    Map<String, dynamic> extractedUserData = jsonDecode(prefs.getString("userData").toString()) as Map<String, dynamic>;
    _token = extractedUserData['token'].toString();
    _roleId = extractedUserData['roleId'].toString();
    _userId = extractedUserData['userId'].toString();
    _userEmail = extractedUserData['userEmail'].toString();
    _userName = extractedUserData['userName'].toString();
    _name = extractedUserData['name'].toString();
    _imgUrl = extractedUserData['imgUrl'].toString();
    _phone = extractedUserData['phone'].toString();

    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _name = null;
    _password=null;
    _roleId = null;
    _imgUrl = null;
    _phone = null;
    _userName = null;
    _userEmail = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }
}
