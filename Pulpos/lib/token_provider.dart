import 'package:flutter/material.dart';

class TokenProvider with ChangeNotifier {
  String _token = '';
  String _username = '';
  List<String> _roles =[] ;

  List<String> get roles => _roles;

  void setRoles(List<String> newRoles){
    _roles = newRoles;
    notifyListeners();
  }

  String get username => _username;

  void setUsername(String newUsername){
    _username = newUsername;
    notifyListeners();
  }

  String get token => _token;



  void setToken(String newToken) {
    _token = newToken;
    notifyListeners();
  }
}
