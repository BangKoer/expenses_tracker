import 'package:expenses_tracker/data/expense_data.dart';
import 'package:expenses_tracker/home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  // initialize hive
  await Hive.initFlutter();

  // open a hive box
  await Hive.openBox("expense_db1");

  runApp(ChangeNotifierProvider(
    create: (context) => ExpenseData(),
    builder: (context, child) => MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
      },
    ),
  ));
}
