import 'package:flutter/material.dart';
import 'package:mijqg/widget/app_bar.dart';

class BacenterDetailPage extends StatefulWidget {
  const BacenterDetailPage({Key? key}) : super(key: key);

  @override
  State<BacenterDetailPage> createState() => _BacenterDetailPageState();
}

class _BacenterDetailPageState extends State<BacenterDetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar:  CustomAppBar(),
        body: Center(
      child:  Text("Bacenter details"),
    ));
  }
}
