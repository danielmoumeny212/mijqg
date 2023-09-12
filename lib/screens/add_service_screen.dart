import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mijqg/Providers/tokens_provider.dart';
import 'package:mijqg/Providers/user_provider.dart';
import 'package:mijqg/service/metting_service.dart';
import 'package:mijqg/widget/app_bar.dart';
import 'package:mijqg/widget/form_input.dart';
import 'package:provider/provider.dart';

class AddServiceScreen extends StatefulWidget {
  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final List<TextEditingController> inputValues = [];

  final _formKey = GlobalKey<FormState>();
  final _serviceController = TextEditingController();
  final _attendanceController = TextEditingController();
  final _newComerController = TextEditingController();
  final _newBornAgainController = TextEditingController();
  final _tithesController = TextEditingController();
  final _offrandesController = TextEditingController();
  String? dropdownValue;

  @override
  void dispose() {
    super.dispose();
    for (var element in inputValues) {
      element.dispose();
    }
  }

  final List<String> services = <String>["Culte de grace "];

  Widget showDropdown(List<dynamic> items) {
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      hint: const Text("selectionner le bacenter concerner"),
      icon: const Icon(
        Icons.arrow_downward,
        color: Colors.deepPurpleAccent,
      ),
      style: const TextStyle(color: Colors.deepPurple),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: items.map<DropdownMenuItem<String>>((dynamic value) {
        return DropdownMenuItem<String>(
          value: value['id'].toString(),
          child: Text(value["name"]),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final preacherController = TextEditingController(
        text: Provider.of<UserProvider>(context, listen: false).user.fullName);
    inputValues.add(_serviceController);
    inputValues.add(preacherController);
    inputValues.add(_attendanceController);
    inputValues.add(_newComerController);
    inputValues.add(_tithesController);
    inputValues.add(_offrandesController);
    inputValues.add(_newBornAgainController);

    return Consumer<AuthTokensProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 10, right: 10),
          physics: const BouncingScrollPhysics(),
          child: Column(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 5.0),
                Text(
                  "Ajoutez un Service",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 25.0,
                  ),
                ),
                const SizedBox(height: 25.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      FormInput(
                          Colors.blue, true, 'Nom du service', Colors.black,
                          helperText: 'Theme du culte ',
                          controller: _serviceController),
                      const SizedBox(height: 5.0),
                      FormInput(
                        Colors.blue,
                        true,
                        'Nom du predicateur ',
                        Colors.black,
                        helperText: 'Predicateur Invite',
                        controller: preacherController,
                      ),
                      const SizedBox(height: 10.0),
                      showDropdown(
                          Provider.of<UserProvider>(context, listen: false)
                              .user
                              .bacenters!),
                      const SizedBox(height: 12.0),
                      Row(children: <Widget>[
                        Expanded(
                            child: FormInput(
                          Colors.blue,
                          true,
                          'Nouveau Venu ',
                          Colors.black,
                          isNumberInput: true,
                          controller: _newComerController,
                        )),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: FormInput(
                          Colors.blue,
                          true,
                          'Nouveau Converti ',
                          Colors.black,
                          isNumberInput: true,
                          controller: _newBornAgainController,
                        )),
                      ]),
                      const SizedBox(
                        height: 10.0,
                      ),
                      FormInput(
                        Colors.blue,
                        true,
                        'Présence',
                        Colors.black,
                        isNumberInput: true,
                        controller: _attendanceController,
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Row(children: <Widget>[
                        Expanded(
                            child: FormInput(
                          Colors.blue,
                          true,
                          'Offrandes ',
                          Colors.black,
                          isNumberInput: true,
                          controller: _offrandesController,
                        )),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                            child: FormInput(
                          Colors.blue,
                          true,
                          'Somme total de la Dime ',
                          Colors.black,
                          isNumberInput: true,
                          controller: _tithesController,
                        ))
                      ]),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: 200.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal[300]),
                ),
                onPressed: () async {
                  final churchId =
                      Provider.of<UserProvider>(context, listen: false)
                          .user
                          .church?["id"];
                  if (_formKey.currentState!.validate()) {
                    var body = {
                      "service_name": _serviceController.text,
                      "predicator": preacherController.text,
                      "attendance": int.parse(_attendanceController.text),
                      "new_comer": int.parse(_newComerController.text),
                      "new_convert": int.parse(_newBornAgainController.text),
                      "offrandes": int.parse(_offrandesController.text),
                      "tithes": int.parse(_tithesController.text),
                      "bacenter": dropdownValue
                    };

                    var headers = {
                      'Content-Type': 'application/json;charset=UTF-8',
                      'Accept': 'application/json',
                      'Authorization': 'JWT ${provider.access}',
                    };
                    var mettingService = MettingService();
                    var serviceAdded = mettingService.addService(
                        "http://10.0.2.2:8000/church/$churchId/bacenters/$dropdownValue/services",
                        body,
                        headers);
                    Navigator.pop(context, serviceAdded);
                  }
                },
                child: Text(
                  'Ajouter',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
            )
          ]),
        ),
      );
    });
  }
}
