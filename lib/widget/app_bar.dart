import 'package:flutter/material.dart';
import 'package:mijqg/Providers/form_state_provider.dart';
import 'package:mijqg/Providers/is_clicked_provider.dart';
import 'package:mijqg/screens/login_screen.dart';
import 'package:mijqg/Providers/user_provider.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  Future<bool?> askForLogout(BuildContext context) async {
    bool? logout = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Deconnexion"),
          content: const Text("Voulez-vous vraiment vous deconnecter ?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Non"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Oui"),
            ),
          ],
        );
      },
    );

    return logout;
  }

  void toLoginPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return Consumer<IsClickedProvider>(builder: (context, provider, child) {
      final user = context.watch<UserProvider>().user;
      final formKey = context.watch<FormKeyProvider>().formKey;
      var formData = context.read<FormKeyProvider>().fromMap();
      var formController = context.watch<FormKeyProvider>().fieldsController;

      return AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: Text(
          '${user.church?["name"]} ',
          style: TextStyle(color: Theme.of(context).hintColor, fontSize: 12.0),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: () async {
              bool? isLogout = await askForLogout(context);
              if (isLogout ?? false) {
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }
            },
          ),
          provider.value
              ? IconButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formController.forEach((element) {
                        print(element.text);
                      });

                      print("Form Data");
                      print(formData);
                    }
                  },
                  icon: const Icon(Icons.save))
              : Container(),
        ],
      );
    });
  }
}
