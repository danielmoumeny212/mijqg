import 'package:flutter/cupertino.dart';

class BacenterPage extends StatefulWidget {
  const BacenterPage({Key? key}) : super(key: key);

  @override
  State<BacenterPage> createState() => _BacenterPageState();
}

class _BacenterPageState extends State<BacenterPage> {
  @override
  Widget build(BuildContext context) {
    return const  SingleChildScrollView(
        child: Center(
      child: Text("BacenterPage"),
    ));
  }
}
