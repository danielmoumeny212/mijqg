import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mijqg/Providers/UserProvider.dart';
import 'package:mijqg/service/MettingService.dart';
import 'package:mijqg/widget/Appbar.dart';
import 'package:mijqg/widget/FormInput.dart';
import 'package:provider/provider.dart';

class AddServiceScreen extends StatefulWidget {
  final String token;
  AddServiceScreen({required this.token});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final List<TextEditingController> inputValues = [];
  
  final _formKey = GlobalKey<FormState>();
  final _serviceController = TextEditingController();
  final _preacherController = TextEditingController();
  final _attendanceController = TextEditingController();
  final _newComerController = TextEditingController();
  final _newBornAgainController = TextEditingController();
  final _tithesController = TextEditingController();
  final _offrandesController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
     _serviceController.dispose();
     _preacherController.dispose();
     _attendanceController.dispose();
     _newComerController.dispose();
     _newBornAgainController.dispose();
     _tithesController.dispose();
     _offrandesController.dispose();
  }

  final List <String> services = <String>["Culte de grace "];



  @override
  Widget build(BuildContext context) {

    inputValues.add(_serviceController);
    inputValues.add(_preacherController);
    inputValues.add(_attendanceController);
    inputValues.add(_newComerController);
    inputValues.add(_tithesController);
    inputValues.add(_offrandesController);
    inputValues.add(_newBornAgainController);


    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        child: Column(
          children: <Widget> [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const  SizedBox(height: 5.0),
                Text("Ajoutez un Service",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 25.0,
                  ),
                ),
                const  SizedBox(height: 25.0),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget> [
                      FormInput(Colors.blue  , true, 'Nom du service', Colors.black , helperText: 'Theme du culte ' ,controller: _serviceController),
                      const  SizedBox(height: 5.0),
                      FormInput(Colors.blue  , true, 'Nom du predicateur ', Colors.black , helperText: 'Predicateur Invite', controller: _preacherController,),
                      const  SizedBox(height: 10.0),
                      Row(
                          children: <Widget>[
                            Expanded(child: FormInput(Colors.blue  , true, 'Nouveau Venu ', Colors.black, isNumberInput: true, controller: _newComerController,)),
                            const SizedBox(width: 10.0,),
                            Expanded(child: FormInput(Colors.blue  , true, 'Nouveau Converti ', Colors.black, isNumberInput: true, controller: _newBornAgainController,)),
                          ]
                      ),
                      const SizedBox(height: 10.0,),
                      FormInput(Colors.blue, true, 'Présence', Colors.black,isNumberInput: true, controller: _attendanceController,),
                      const SizedBox(height: 5.0,),
                      Row(
                          children: <Widget>[
                            Expanded(
                                child: FormInput(Colors.blue  , true, 'Offrandes ', Colors.black, isNumberInput: true, controller: _offrandesController,)),
                            const SizedBox(width: 10.0,),
                            Expanded(child: FormInput(Colors.blue  , true, 'Somme total de la Dime ', Colors.black ,isNumberInput: true, controller: _tithesController,))
                          ]
                      ),
                    ],
                  ),
                ),
              ],

          ),
            const SizedBox(height: 20.0,),
            Container(
              width: 200.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal[300]),
                ),
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    var body = {

                     "service_name": _serviceController.text,
                     "predicator": _preacherController.text,
                     "attendance": int.parse(_attendanceController.text),
                     "new_comer": int.parse(_newComerController.text),
                     "new_convert": int.parse(_newBornAgainController.text),
                     "offrandes": int.parse(_offrandesController.text),
                     "tithes": int.parse(_tithesController.text),
                     "bacenter_leader": Provider.of<UserProvider>(context, listen: false).user.id
                    };
                    var headers = {
                      'Content-Type': 'application/json;charset=UTF-8',
                      'Accept': 'application/json',
                      'Authorization': 'JWT ${widget.token}',
                    };
                    var mettingService = MettingService();
                    var serviceAdded = mettingService.addService(body, headers);
                    Navigator.pop(context, serviceAdded);

                  }

                },
                child: Text('Ajouter',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),),

              ),
            )
        ]
        ),
      ),
    );
  }
}
