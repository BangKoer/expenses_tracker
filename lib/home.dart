import 'package:expenses_tracker/components/expense_summary.dart';
import 'package:expenses_tracker/components/expense_tile.dart';
import 'package:expenses_tracker/data/expense_data.dart';
import 'package:expenses_tracker/models/expenses.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Text controller
  final newExpense_nameController = TextEditingController();
  final newExpense_amountController = TextEditingController();
  final newExpense_CentsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // prepare data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // add new expense
  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add New Expense"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // expense name field
            TextField(
              decoration: InputDecoration(
                hintText: "Expense Name",
              ),
              controller: newExpense_nameController,
            ),

            // expense amount field
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Dollar",
                    ),
                    controller: newExpense_amountController,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cent",
                    ),
                    controller: newExpense_CentsController,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: save,
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.green,
          ),
          // cancel button
          MaterialButton(
            onPressed: cancel,
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.red,
          )
        ],
      ),
    );
  }

  // delete function
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  // save function
  void save() {
    if (newExpense_amountController.text.isNotEmpty &&
        newExpense_CentsController.text.isNotEmpty) {
      // put dollar and cents together
      String dollCent =
          '${newExpense_amountController.text}.${newExpense_CentsController.text}';

      // Create expense item
      ExpenseItem newExpense = ExpenseItem(
        name: newExpense_nameController.text,
        amount: dollCent,
        dateTime: DateTime.now(),
      );

      // add new expense
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    }

    // add pop message
    Navigator.pop(context);
    clear();
  }

  // cancel function
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // clear Controller
  void clear() {
    newExpense_amountController.clear();
    newExpense_nameController.clear();
    newExpense_CentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            backgroundColor: Colors.black87,
            elevation: 0,
            title: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Image.asset("assets/spending.png", scale: 10.0),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Expense",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "Tracker App",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Colors.grey[300],
          floatingActionButton: FloatingActionButton(
            onPressed: addNewExpense,
            child: Icon(Icons.add),
            backgroundColor: Colors.black,
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ListView(
              children: [
                // weekly summary
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),

                const SizedBox(height: 20),
                // expense list
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenseList().length,
                  itemBuilder: (context, index) => ExpenseTile(
                    name: value.getAllExpenseList()[index].name,
                    amount: value.getAllExpenseList()[index].amount,
                    dateTime: value.getAllExpenseList()[index].dateTime,
                    deleteTapped: (p0) =>
                        deleteExpense(value.getAllExpenseList()[index]),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
