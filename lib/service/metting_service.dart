import 'package:mijqg/service/network_helper.dart';

import '../models/ServiceMetting.dart';

class MettingService extends NetworkHelper{
   final String _addServiceUrl = 'http://192.168.1.156:8000/service/create';
   final String _getBacenterServiceUrl = 'http://192.168.1.156:8000/service/all/user/';

   Future<dynamic> addService(body, headers) async {
      var response = await postData(url: _addServiceUrl, body: body, headers: headers);
      if (response.isOk) return ServiceMetting.fromJson(response.unwrap());
      return response.unwrap();
      
   }
   Future <dynamic> getAllServiceByUser({required int id , required Map headers}) async{
      List<ServiceMetting>  list = [];
      var response = await fetchData(url: '$_getBacenterServiceUrl$id', headers: headers);
      if(response.isError) return response.unwrap();
      for(var element in response.unwrap()){
         list.add(ServiceMetting.fromJson(element));
      }
      return list;
   }

}