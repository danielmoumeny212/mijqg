import 'package:flutter/material.dart';
import 'package:mijqg/widget/app_bar.dart';
import 'package:mijqg/widget/form_input.dart';

class AddMembers extends StatefulWidget {
  const AddMembers({Key? key}) : super(key: key);

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> get formInputData => [
        {
          'color': Colors.blue,
          'isRequired': true,
          'label': 'Nom',
          'labelColor': Colors.black,
          'controller': _nameController,
        },
        {
          'color': Colors.blue,
          'isRequired': true,
          'label': 'Prenom',
          'labelColor': Colors.black,
        },
        {
          'color': Colors.blue,
          'isRequired': true,
          'label': 'adresse',
          'labelColor': Colors.black,
        },
        {
          'color': Colors.blue,
          'isRequired': true,
          'label': 'Tel',
          'labelColor': Colors.black,
          'isNumberInput': true,
        },
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 10.0,
            ),
            Text('Formulaire Membre',
                style: Theme.of(context).textTheme.headline5),
            const SizedBox(
              height: 10.0,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Text.rich(
                TextSpan(
                  text:
                      "ce formulaire vous permet d'ajouter des membres stables de votre bacenter",
                  style: TextStyle(color: Colors.black),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    for (var inputData in formInputData)
                      FormInput(
                        inputData['color'],
                        inputData['isRequired'],
                        inputData['label'],
                        inputData['labelColor'],
                        controller: inputData['controller'],
                        isNumberInput: inputData['isNumberInput'] ?? false,
                      ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                elevation: 1.0,
                minimumSize: const Size.fromHeight(40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
