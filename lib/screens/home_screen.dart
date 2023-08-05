import 'package:flutter/material.dart';
import 'package:mijqg/Providers/user_provider.dart';
import 'package:mijqg/models/service_meeting.dart';
import 'package:mijqg/screens/add_service_screen.dart';
import 'package:mijqg/screens/bacenter_screen.dart';
import 'package:mijqg/screens/profil_screen.dart';
import 'package:mijqg/service/metting_service.dart';
import 'package:mijqg/widget/app_bar.dart';
import 'package:mijqg/utils/contants.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
   final String token;
   const HomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    int selectedIndex = 0;
    Widget _profilPage = ProfilPage();
    Widget _bacenterPage = BacenterPage();

    List<ServiceMetting> _services = [];

  void makeRequest () async{
    final userId = Provider.of<UserProvider>(context, listen: false).user.id;
    var headers = {
      'Content-Type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'JWT ${widget.token}',
    };
    // var service = MettingService();
    // var response = await service.getAllServiceByUser(id: userId, headers: headers);
    // print(response);
    // if(response is List<ServiceMetting>){
    //   setState(() {
    //     _services = response;
    //   });
    // }


  }


  @override
  void initState() {
    super.initState();
    makeRequest();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(),
      body: getBody(),
      floatingActionButton: selectedIndex != 2 ? FloatingActionButton(
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add, color: Colors.white ,),
        onPressed: () async{
          var serviceAdded = await Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddServiceScreen(token: widget.token,)));
          if (serviceAdded is ServiceMetting) makeRequest();
        },
      ): null,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
           BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Accueil",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.church),
            label: "bacenter",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "profil"
          )
        ],
         onTap: (int index) {
          onTapHandler(index);
        },
        
      
        ),
    );
   


  }
  void onTapHandler(int index)  {
    setState(() {
      selectedIndex = index;
    });
  }

    Widget getBody( )  {
    if(selectedIndex == 0) {
      return Container(
        child: const Center(child: Text("HOME")),);
    } else if(selectedIndex==1) {
      return _bacenterPage;
    } else {
      return _profilPage;
    }
  }
}
