import "package:flutter/foundation.dart" show ChangeNotifier;

class AuthTokens extends ChangeNotifier {
  String _accessToken = "";
  String _refreshToken = "";

  String get access => _accessToken;
  String get refresh => _refreshToken;

  void setAccessToken(String token) {
    _accessToken = token;
    notifyListeners();
  }

  void setRefreshToken(String refresh) {
    _refreshToken = refresh;
    notifyListeners();
  }

  AuthTokens.formMap(Map<String, String> map) {
    _accessToken = map["access_token"] ?? "";
    _refreshToken = map["refresh_token"] ?? "";
    notifyListeners();
  }
}
