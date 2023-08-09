import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mijqg/Providers/user_provider.dart';
import 'package:mijqg/screens/slidable_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BacenterPage extends StatefulWidget {
  const BacenterPage({Key? key}) : super(key: key);

  @override
  State<BacenterPage> createState() => _BacenterPageState();
}

class _BacenterPageState extends State<BacenterPage> {
  final List<SlidableAction> actions = [
    SlidableAction(
        // An action can be bigger than the others.
        onPressed: (context){},
        backgroundColor: const Color(0xFF7BC043),
        foregroundColor: Colors.white,
        icon: Icons.add_box_outlined,
        label: 'Ajouter un Service',
      ),
      SlidableAction(
        onPressed: (context){},
        backgroundColor: const Color(0xFF0392CF),
        foregroundColor: Colors.white,
        icon: Icons.remove_red_eye_sharp,
        label: 'Detail',
      ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, provider, child) {
      final List<dynamic>? bacenters = provider.user.bacenters;
      return ListView.builder(
          itemCount: bacenters?.length,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemBuilder: (context, index) => SlidableWidget(
                actions: actions,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      firstLetter(bacenters?[index]["name"]),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                  title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bacenters?[index]["name"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(bacenters?[index]["quarter"])
                      ]),
                ),
              ));
    });
  }

  void onDismissed(DismissDirection direction) {}

  String firstLetter(String data) {
    var splitted = data.split(' ');
    String returning = "";
    for (var value in splitted) {
      returning += value[0].toUpperCase();
    }
    return returning;
  }
}
