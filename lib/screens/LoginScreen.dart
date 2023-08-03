// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mijqg/Providers/UserProvider.dart';
import 'package:mijqg/service/AuthService.dart';
import 'package:provider/provider.dart';

import '../models/User.dart';
import '../utils/validate_input.dart';
import '../utils/contants.dart';
import 'Homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _focusNodePassword = FocusNode();
  final userInputController = TextEditingController();
  final pwdInputController = TextEditingController();
  bool _obscurePassword = true;

  void makeRequest({required accessToken, required context}) async {
    var auth = AuthService();
    Map<String, String> customHeader = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'JWT $accessToken',
    };
    User user = await auth.getUser(headers: customHeader);
    Provider.of<UserProvider>(context, listen: false).setUser(user);
  }

  void showCustomSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(
            seconds: 2), // Durée pendant laquelle la SnackBar est affichée
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNodePassword.dispose();
    userInputController.dispose();
    pwdInputController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        //  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 30.0,
              ),
              const CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('images/playstore.png'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'Loyaute International',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                "Connexion au compte",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(children: [
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Identifiant du berger",
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          labelStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          ),
                        ),
                        validator: (value) => validateLogin(
                            value, "ce champ ne peut pas être vide"),
                        controller: userInputController,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Mot de passe",
                          prefixIcon: const Icon(
                            Icons.password_outlined,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              color: Colors.black,
                              icon: _obscurePassword
                                  ? const Icon(Icons.visibility_outlined)
                                  : const Icon(Icons.visibility_off_outlined)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => validateLogin(
                            value, "ce champ ne peut pas être vide"),
                        controller: pwdInputController,
                        focusNode: _focusNodePassword,
                        obscureText: _obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ]),
                  )),
              const SizedBox(
                height: 40.0,
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var auth = AuthService();
                        var result = await auth.login(
                            userInputController.text, pwdInputController.text);
                        if (!result.isError) {
                          // Le résultat est une valeur de réussite
                          showCustomSnackBar(context, "Connexion réussie");
                          FocusScope.of(context).requestFocus(FocusNode());
                          String access = await result.unwrap()["access"];
                          String refresh = result.unwrap()["refresh"];
                          makeRequest(accessToken: access, context: context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(token: access)));
                        }
                        // Le résultat est une erreur
                        showCustomSnackBar(context, "Mauvaise identification");
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    },
                    child: const Text("Connnexion"),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
