import 'package:flutter/material.dart';

class FormKeyProvider extends ChangeNotifier {
  final List<TextEditingController> _fieldsController = [];
  List<TextEditingController> get fieldsController  => _fieldsController;
  final _formKey = GlobalKey<FormState>();

  void setFieldController(TextEditingController fieldController) {
    _fieldsController.add(fieldController);
  }

  Map<String, String> fromMap() {
    return _fieldsController.isNotEmpty
        ? {
            "name": _fieldsController[0].text,
            "first_name": _fieldsController[1].text,
            "email": _fieldsController[2].text,
            "cellphone": _fieldsController[3].text
          }
        : {};
  }

  GlobalKey<FormState> get formKey => _formKey;
}
