import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
import 'package:mijqg/widget/Appbar.dart';


class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  bool isClicked = false;
   var _image;

  Future <void> getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }


  void toggleClicked(){
    setState(() {
      isClicked = !isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {


    Map<String, String> user = {
       "nom": "John Doe",
       "email": "mijqg@gmail.com",
        "tel": "064649019",
    };

    final h  = MediaQuery.of(context).size.height;
    return  Scaffold(
      backgroundColor: Colors.teal,
       appBar:const CustomAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
            SizedBox(
              height: h*0.03,
            ),
           GestureDetector(
             onTap: getImage,
             child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.grey,
                 backgroundImage: _image == null ? null : FileImage(_image),
               child: _image == null
                   ? const Icon(Icons.add_a_photo, size: 50, color: Colors.white)
                   : null,
              ),
           ),
            SizedBox(
              height: h*0.02,
            ),
            Text(
              'John Doe',
              style: GoogleFonts.pacifico(
                fontSize: 35.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Berger de centre',
              style: GoogleFonts.sourceSansPro(
                 fontSize: 20.0,
                color: Colors.teal.shade100,
                fontWeight: FontWeight.bold
              ),
            ),
              SizedBox(
                height: h*0.01,
              ),
            // FormInput(Colors.black, false, 'Nom de famille', Colors.black),
            GestureDetector(
              onTap: toggleClicked,
              child: Card(
                 color: Colors.white,
                 child: ListTile(
                   leading: const Icon(
                           Icons.account_circle,
                           color: Colors.teal,),
                   title:  isClicked?  TextFormField(
                     decoration: const InputDecoration(
                       border: InputBorder.none,
                     ),
                     initialValue: user["nom"],
                   ): Text(user['nom']!,
                     style: GoogleFonts.sourceSansPro(
                       fontSize: 20.0,
                       color: Colors.teal.shade900,

                     ),
                   )

                 )
              ),
            ),
              SizedBox(
                height: h*0.01,
              ),
              GestureDetector(
                onTap: toggleClicked,
                child: Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: const Icon(
                        Icons.email,
                        color: Colors.teal,),
                      title:  isClicked?  TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        initialValue: user["email"],
                      ): Text(user['email']!,
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20.0,
                          color: Colors.teal.shade900,

                        ),
                      )

                    )
                ),
              ),
              SizedBox(
                height: h*0.01,
              ),
              GestureDetector(
                onTap: toggleClicked,
                child: Card(
                    color: Colors.white,
                    child: ListTile(
                      leading: const Icon(
                        Icons.phone,
                        color: Colors.teal,),
                      title:  isClicked ? TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        initialValue: user["tel"],
                      ):  Text(user['tel']!,
                        style: GoogleFonts.sourceSansPro(
                          fontSize: 20.0,
                          color: Colors.teal.shade900,

                        ),
                      )

                    )
                ),
              ),
             SizedBox(height: 10.0,),
             isClicked?
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [

                    ElevatedButton(
                       style: ElevatedButton.styleFrom(
                         primary: Colors.white
                       ),
                        onPressed: (){},
                        child: Text(
                      "Sauvergarder",
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 20.0,
                        color: Colors.black,
                      )
                    ))
                  ],
               ): Container()





          ]
        ),
      ),
    );
  }
}
