import 'package:flutter/material.dart' show TextEditingController;

Map<String, String>parseInputToRequestBody(List<TextEditingController> elements){
   Map<String, String> map = {};
   for (var element in elements) {
     map[element.text] = element.text;
   }
   return map;
}