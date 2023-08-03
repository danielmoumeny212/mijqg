import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:mijqg/service/AuthService.dart';

abstract class  NetworkHelper {
   // final  List<int>statusCode = [200, 201];
   Future <Result<dynamic, dynamic>> fetchData({required url , required headers}) async {
    var endpoint = Uri.parse(url);
    http.Response response  = await  http.get(endpoint , headers:headers);
    if (response.statusCode == 200 || response.statusCode == 201){
      String data = response.body;
      return Result<dynamic, int>.ok(convert.jsonDecode(data));

    } else {
      return Result.error(response.statusCode);
    }

  }
   Future<Result<dynamic, dynamic>> postData({required String url,required Map body, required  headers }) async {
     var endpoint = Uri.parse(url);
     http.Response response = await http.post(
       endpoint,
       headers: headers,
       body: convert.jsonEncode(body),
     );
     if (response.statusCode == 200) {
       String data = response.body;
       return Result<dynamic, int>.ok(convert.jsonDecode(data));
     } else {
       print(response);
       return Result<String, dynamic>.error(response.statusCode);
     }
   }

}