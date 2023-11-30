import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ExpenseTile extends StatelessWidget {
  final String name, amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;

  ExpenseTile(
      {required this.name,
      required this.amount,
      required this.dateTime,
      required this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          // delete button
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.red,
          ),
        ],
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text(
            "${dateTime.year.toString()}/${dateTime.month.toString()}/${dateTime.day.toString()}"),
        trailing: Text("\$" + amount),
      ),
    );
  }
}
