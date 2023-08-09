import 'package:flutter/material.dart';
import 'package:mijqg/Providers/user_provider.dart';
import 'package:mijqg/models/service_meeting.dart';
import 'package:mijqg/screens/add_service_screen.dart';
import 'package:mijqg/screens/bacenter_screen.dart';
import 'package:mijqg/screens/profil_screen.dart';
import 'package:mijqg/widget/app_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String token;
  const HomePage({Key? key, required this.token}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final Widget _profilPage = const ProfilPage();
  final Widget _bacenterPage = const BacenterPage();

  final List<ServiceMetting> _services = [];

  void makeRequest() async {
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
      body: NotificationListener<ScrollNotification>(
        onNotification: _onScroll, // Attach the _onScroll callback here
        child: getBody(),
      ),
      floatingActionButton: selectedIndex == 0
          ? !showExtendedFAB
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.teal,
                  label: const Text("nouveau service"),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    var serviceAdded = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddServiceScreen()));
                    if (serviceAdded is ServiceMetting) makeRequest();
                  },
                )
              : FloatingActionButton(
                  backgroundColor: Colors.teal,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    var serviceAdded = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddServiceScreen()));
                    if (serviceAdded is ServiceMetting) makeRequest();
                  },
                )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        unselectedIconTheme: const IconThemeData(color: Colors.black, opacity: 1.0, size: 20),
        currentIndex: selectedIndex,
        selectedIconTheme:
            const IconThemeData(color: Colors.teal, opacity: 1.0, size: 30),
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
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profil")
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  bool showExtendedFAB = false;

  bool _onScroll(ScrollNotification notification) {
    // Check if the user is scrolling
    if (notification is ScrollUpdateNotification) {
      // Check if the scroll position is greater than 0, indicating the user has scrolled down
      bool scrolledDown = notification.metrics.pixels > 0;

      // Toggle the FAB based on the scroll position
      setState(() {
        showExtendedFAB = scrolledDown;
      });
    }

    // Always return true to continue propagating the notification to other listeners
    return true;
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return const Center(child: Text("Home"));
    } else if (selectedIndex == 1) {
      return _bacenterPage;
    } else {
      return _profilPage;
    }
  }
}
