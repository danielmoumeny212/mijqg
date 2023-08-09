import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlidableWidget<T> extends StatelessWidget {
  final Widget child;
  final List<SlidableAction> actions; 

  const SlidableWidget({
    required this.child,
    required this.actions, 
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Slidable(
      endActionPane: ActionPane(
        extentRatio: actions.length == 2 ? 0.5: actions.length / 10,
        motion: const ScrollMotion(),
        children: actions, 
      ),
      child: child);
}
