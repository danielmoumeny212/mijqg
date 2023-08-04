import 'package:flutter/material.dart';
import 'package:mijqg/Providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'screens/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Loyauté Internationnal',
        theme: ThemeData(
          fontFamily: 'roboto',
          primarySwatch: Colors.blue,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}


