import 'package:flutter/material.dart';
import 'package:mijqg/screens/profilscreen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.teal,
      // title: const  Text("Center de la base ",
      //     style: TextStyle(
      //         fontSize: 25.0
      //     )),
      actions: <Widget> [
        IconButton(
          icon: const Icon(Icons.logout , color: Colors.white,),
          onPressed: (){
          },

        ),
        IconButton(
            onPressed: (){
             Navigator.push(context , MaterialPageRoute(builder: (context) => const ProfilPage() ));
            },
            icon: const Icon(Icons.account_circle)
        )
      ],
    );
  }
}
