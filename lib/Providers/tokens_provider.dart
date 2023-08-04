import "package:flutter/foundation.dart" show ChangeNotifier;

class AuthTokensProvider extends ChangeNotifier {
  String _accessToken = "";
  String _refreshToken = "";

  String get access => _accessToken;
  String get refresh => _refreshToken;

 
  formMap(Map<String, dynamic> map) {
    _accessToken = map["access"];
    _refreshToken = map["refresh"];
    notifyListeners();
  }

  void setAccessToken(String token) {
    _accessToken = token;
    notifyListeners();
  }

  void setRefreshToken(String refresh) {
    _refreshToken = refresh;
    notifyListeners();
  }
}
