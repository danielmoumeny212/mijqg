import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:mijqg/models/User.dart';
import 'package:mijqg/service/NetworkHelper.dart';

class AuthService extends NetworkHelper {

   final  String _authUrl = 'http://192.168.100.2:8000/auth/jwt/create/';
   final  String _infoUrl = 'http://192.168.100.2:8000/auth/users/me';

   Future<Result<dynamic, dynamic>> login(String email, String pwd) async {
     return postData(url: _authUrl, body: {"email": email, "password": pwd }, headers: const  {'Content-Type': 'application/json;charset=UTF-8'});
  }



   Future<User> getUser({headers= const  {'Content-Type': 'application/json;charset=UTF-8'}}) async {
     var response = await fetchData(url: _infoUrl, headers: headers);
     return User.fromJson(response.unwrap());
  }


}

class Result<T, E> {
  final T? value;
  final E? error;

  Result.ok(this.value) : error = null;
  Result.error(this.error) : value = null;

  bool get isOk => value != null;
  bool get isError => error != null;

   unwrap() {
    if (isOk) {
      return value!;
    } else {
      return error!;

    }
  }
}
