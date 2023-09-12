import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mijqg/Providers/user_provider.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool isClicked = false;
  var _image;

  Future<void> getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  void toggleClicked() {
    setState(() {
      isClicked = !isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, String> users = {
      "nom": "John Doe",
      "email": "mijqg@gmail.com",
      "tel": "064649019",
    };

    final h = MediaQuery.of(context).size.height;
    return Consumer<UserProvider>(builder: (context, provider, child) {
      var user = provider.user;
      return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        // physics: const BouncingScrollPhysics(),
        child: Column(
            verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: h * 0.03,
              ),
              GestureDetector(
                onTap: getImage,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: _image != null
                      ? FileImage(_image) // Cast to ImageProvider<Object>
                      : provider.user.image != ""
                          ? NetworkImage(provider
                              .user.image) // Cast to ImageProvider<Object>
                          : _image,
                  child: _image == null && provider.user.image == ""
                      ? const Icon(Icons.add_a_photo,
                          size: 50, color: Colors.white)
                      : null,
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Text(
                '${user.firstName}  ${user.name}',
                style: GoogleFonts.pacifico(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${user.statut} ',
                style: GoogleFonts.sourceSansPro(
                    fontSize: 20.0,
                    color: Colors.teal.shade200,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              // FormInput(Colors.black, false, 'Nom de famille', Colors.black),
              GestureDetector(
                onTap: toggleClicked,
                child: Card(
                    color: Colors.white,
                    child: ListTile(
                        leading: const Icon(
                          Icons.account_circle,
                          color: Colors.teal,
                        ),
                        title: isClicked
                            ? TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                initialValue: user.name,
                              )
                            : Text(
                                user.name,
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 20.0,
                                  color: Colors.teal.shade900,
                                ),
                              ))),
              ),
              SizedBox(
                height: h * 0.01,
              ),
              GestureDetector(
                onTap: toggleClicked,
                child: Card(
                    color: Colors.white,
                    child: ListTile(
                        leading: const Icon(
                          Icons.email,
                          color: Colors.teal,
                        ),
                        title: isClicked
                            ? TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                initialValue: user.email,
                              )
                            : Text(
                                provider.user.email,
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 20.0,
                                  color: Colors.teal.shade900,
                                ),
                              ))),
              ),

              SizedBox(
                height: h * 0.01,
              ),
              GestureDetector(
                onTap: toggleClicked,
                child: Card(
                    color: Colors.white,
                    child: ListTile(
                        leading: const Icon(
                          Icons.phone,
                          color: Colors.teal,
                        ),
                        title: isClicked
                            ? TextFormField(
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                initialValue: provider.user.cellphone,
                              )
                            : Text(
                                users['tel']!,
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 20.0,
                                  color: Colors.teal.shade900,
                                ),
                              ))),
              ),
              const SizedBox(
                height: 10.0,
              ),
              isClicked
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              surfaceTintColor: Colors.teal,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                            onPressed: () {},
                            child: Text("Sauvergarder",
                                style: GoogleFonts.sourceSansPro(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                )))
                      ],
                    )
                  : Container()
            ]),
      );
    });
  }
}
