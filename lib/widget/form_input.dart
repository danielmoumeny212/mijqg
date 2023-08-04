import 'package:flutter/material.dart';
import 'package:mijqg/utils/validate_input.dart';


class FormInput extends StatelessWidget {
  final Color  borderSideColor;
  final bool isDense;
  final String label;
  final Color labelColor;
  String  helperText;
  bool isNumberInput;
  final TextEditingController? controller;
  // String? Function (String? value)  validator;


  FormInput(
        this.borderSideColor,
        this.isDense,
        this.label,
        this.labelColor,
        // this.validator,
        {
        this.helperText ='' ,
        this.isNumberInput = false,
        this.controller,
        Key? key
        }) :  super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderSideColor),
        ),
        isDense: isDense ,
        labelText: label,
        labelStyle: TextStyle(
          color: labelColor,
          fontSize: 15.0
        ),
        helperText: helperText,

      ),
      keyboardType: isNumberInput? TextInputType.number : null,
      // initialValue: isNumberInput? '0' : null,
      validator: (value) => validateFormFields(value , isNumberInput),
      controller: controller,
    );
  }
}



