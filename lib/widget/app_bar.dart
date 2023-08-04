import 'package:flutter/material.dart';
import 'package:mijqg/screens/login_screen.dart';
import 'package:mijqg/screens/profil_screen.dart';

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

  void toLoginPage(BuildContext context){
     Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.teal,
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () async {
            bool? isLogout = await askForLogout(context);
            if (isLogout ?? false) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            }
          },
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilPage()),
            );
          },
          icon: const Icon(Icons.account_circle),
        ),
      ],
    );
  }
}
