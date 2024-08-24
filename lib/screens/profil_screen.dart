import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mijqg/Providers/form_state_provider.dart';
import 'package:mijqg/Providers/is_clicked_provider.dart';
import 'package:mijqg/Providers/user_provider.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  // ignore: prefer_typing_uninitialized_variables
  var boolProvider;
  // ignore: prefer_typing_uninitialized_variables
  var _image;
  Future<void> getImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isClicked = context.watch<IsClickedProvider>().value;
    boolProvider = Provider.of<IsClickedProvider>(context, listen: false);
    final formProvider = context.watch<FormKeyProvider>();

    final h = MediaQuery.of(context).size.height;
    return Consumer<UserProvider>(builder: (context, provider, child) {
      var user = provider.user;
      final nameController = TextEditingController(text: user.name);
      final firstNameController = TextEditingController(text: user.firstName);
      final emailController = TextEditingController(text: user.email);
      final cellphoneController = TextEditingController(text: user.cellphone);
      formProvider.setFieldController(nameController);
      formProvider.setFieldController(firstNameController);
      formProvider.setFieldController(emailController);
      formProvider.setFieldController(cellphoneController);

      return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Form(
          key: formProvider.formKey,
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
                buildUserCard(
                    leadingIcon: const Icon(
                      Icons.account_circle,
                      color: Colors.teal,
                    ),
                    controller: nameController,
                    initialValue: user.name,
                    text: user.name,
                    isToggled: isClicked),
                SizedBox(
                  height: h * 0.01,
                ),
                buildUserCard(
                    leadingIcon: const Icon(
                      Icons.account_circle,
                      color: Colors.teal,
                    ),
                    controller: firstNameController,
                    initialValue: user.firstName,
                    text: user.firstName,
                    isToggled: isClicked),
                SizedBox(
                  height: h * 0.01,
                ),
                buildUserCard(
                    leadingIcon: const Icon(
                      Icons.email,
                      color: Colors.teal,
                    ),
                    controller: emailController,
                    initialValue: user.email,
                    text: user.email,
                    isToggled: isClicked),
                SizedBox(
                  height: h * 0.01,
                ),
                buildUserCard(
                    leadingIcon: const Icon(
                      Icons.phone,
                      color: Colors.teal,
                    ),
                    controller: cellphoneController,
                    initialValue: user.cellphone,
                    text: user.cellphone,
                    isToggled: isClicked),
                const SizedBox(
                  height: 10.0,
                ),
              ]),
        ),
      );
    });
  }

  GestureDetector buildUserCard({
    required Icon leadingIcon,
    required TextEditingController controller,
    String? initialValue,
    bool isToggled = false,
    String text = '',
  }) {
    return GestureDetector(
      onTap: () => boolProvider.setValue(!isToggled),
      child: Card(
          color: Colors.white,
          child: ListTile(
              leading: leadingIcon,
              title: isToggled
                  ? TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      initialValue: initialValue,
                      controller: controller,
                    )
                  : Text(
                      text,
                      style: GoogleFonts.sourceSansPro(
                        fontSize: 20.0,
                        color: Colors.teal.shade900,
                      ),
                    ))),
    );
  }
}
