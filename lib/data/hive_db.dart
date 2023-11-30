import 'package:expenses_tracker/models/expenses.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  // reference out box
  final _mybox = Hive.box("expense_db1");

  // write data
  void saveData(List<ExpenseItem> allExpense) {
    /* 
    
    Hive can only store basic primitive type like strings and dateTime not custom object
    so convert Expense item obj into type that can be stored to db

    convt this 

    allExpense = [  ExpenseItem( name / amount / dateTime), ...  ]

    to 

    allExpense = [   [name , amount, dateTime], ...   ]
    
    */

    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      // convt each item on allExpense into a list of storable type (string, dateTime, etc)
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    _mybox.put("ALL_EXPENSES1", allExpensesFormatted);
  }

  // read data
  List<ExpenseItem> readData() {
    /*
     
     Data is stored in Hive as a list of String and dateTime
     so convert saved data into ExpenseItem obj
    
     savedData = [  [name, amount, dateTime]  ]

     into

     ExpenseItem( name / amount / dateTime)
     
     */
    List savedExpenses = _mybox.get("ALL_EXPENSES1") ?? [];
    List<ExpenseItem> allExpense = [];

    for (var i = 0; i < savedExpenses.length; i++) {
      // collect individual expense data
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      // create expense item
      ExpenseItem expense =
          ExpenseItem(name: name, amount: amount, dateTime: dateTime);

      // add expense to overall list of expenses
      allExpense.add(expense);
    }
    return allExpense;
  }
}
