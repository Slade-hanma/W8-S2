import 'package:flutter/material.dart';
import '../../models/expense.dart';
import 'expenses_form.dart';
import 'expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void onExpenseRemoved(Expense expense) {
    // Store the removed expense for potential restoration
    final removedExpense = expense;

    setState(() {
      _registeredExpenses.remove(expense);
    });

    // Clear any existing SnackBars
    ScaffoldMessenger.of(context).clearSnackBars();

    // Show the SnackBar with an undo action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedExpense.title} removed!'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            // Restore the removed expense
            setState(() {
              _registeredExpenses.add(removedExpense);
            });
          },
        ),
      ),
    );
  }

  void onExpenseCreated(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void onAddPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => ExpenseForm(onCreated: onExpenseCreated),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAddPressed,
          ),
        ],
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
      ),
      body: _registeredExpenses.isEmpty
          ? Center(child: Text('No expenses found!', style: TextStyle(fontSize: 20)))
          : ExpensesList(
              expenses: _registeredExpenses,
              onExpenseRemoved: onExpenseRemoved,
            ),
    );
  }
}
