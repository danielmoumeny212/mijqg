import 'package:flutter/material.dart';
import 'package:mijqg/Providers/user_provider.dart';
import 'package:mijqg/models/ServiceMetting.dart';
import 'package:mijqg/screens/add_service_screen.dart';
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



  Future <bool>  _onBackButtonPressed(BuildContext context ) async {
   bool ? exitApp = await showDialog(
     context: context,
     builder: (BuildContext context ){
        return AlertDialog(
          title: const Text('Vraiment ?', style: kAlertTitleDialogStyle,
          ),
          content:  const Text("Voulez vous quittez l'application ",),
          actions: <Widget>[
             TextButton(
               onPressed: (){
                 Navigator.of(context).pop(false);
               },
               child: Text("Non", style: TextStyle(color: Colors.teal[400])),
             ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop(true);
              },
              child: Text("Oui", style: TextStyle(color: Colors.teal[400]),),
            ),

          ],

        );

     }
   );
   return exitApp ?? false;

  }

  @override
  void initState() {

    super.initState();
    makeRequest();
  }

  @override
  // TODO: implement mounted


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.teal,
        appBar: const CustomAppBar(),
        body: Container(
          decoration: const  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
          ),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){
                      print("tap");
                      makeRequest();
                    },
                    child: Column(

                       children: <Widget>[
                         const SizedBox(height: 30.0,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: <Widget>[
                             Expanded(
                               flex: 2,
                               child: Column (
                               crossAxisAlignment: CrossAxisAlignment.start,
                                 children:  <Widget> [
                                   Text(_services[index].serviceName, textAlign: TextAlign.center,style: const TextStyle(
                                     fontSize: 22.0,
                                     fontWeight: FontWeight.bold
                                   ),
                                   ),
                                   const SizedBox(height: 10.0),
                                   Text('presence: ${_services[index].attendance}', textAlign: TextAlign.center, style: TextStyle(fontSize: 15.0)),

                                 ],
                               ),
                             ),
                             Expanded(
                               flex: 1,
                               child: Column(
                                 children:  <Widget> [
                                   Text(_services[index].date, textAlign: TextAlign.center, style: const TextStyle(fontSize: 15.0),),
                                   const SizedBox(height: 10.0,)
                                 ],
                               ),
                             )
                           ]
                         ),
                       ]
                    ),
                  );
            },
            itemCount: _services.length,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: const Icon(Icons.add, color: Colors.white ,),
          onPressed: () async{
            var serviceAdded = await Navigator.push(context, MaterialPageRoute(builder: (context) =>  AddServiceScreen(token: widget.token,)));
            if (serviceAdded is ServiceMetting) makeRequest();
          },
        ),
      ),
    );


  }
}
