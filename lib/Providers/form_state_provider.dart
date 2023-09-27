import 'package:flutter/material.dart';

class FormKeyProvider extends ChangeNotifier {
  List<TextEditingController> fieldsController = [];
  final _formKey = GlobalKey<FormState>();

  void setFieldController(TextEditingController fieldController) {
    fieldsController.add(fieldController);
  }

  GlobalKey<FormState> get formKey => _formKey;
}
