// lib\EX-1-2-3\screens\expenses\expenses_form.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  
  // New state for selected category
  Category? _selectedCategory;

  String get title => _titleController.text;

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    Navigator.pop(context);
  }

  void onAdd() {
    String title = _titleController.text;
    double amount = double.parse(_valueController.text);

    // Create the expense with the selected category
    Expense expense = Expense(
      title: title,
      amount: amount,
      date: DateTime.now(),
      category: _selectedCategory ?? Category.food, // Default to food if no category is selected
    );

    widget.onCreated(expense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: _valueController,
            maxLength: 50,
            decoration: const InputDecoration(
              prefix: Text('\$ '),
              label: Text('Amount'),
            ),
          ),
          // Dropdown for selecting category

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                DropdownButton<Category>(
                value: _selectedCategory,
                hint: const Text('Select Category'),
                items: Category.values.map((Category category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.toString().split('.').last.toUpperCase()), // Display category in uppercase
                  );
                }).toList(),
                onChanged: (Category? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
              ),
              Container(child: Row(
                children: [
                  ElevatedButton(onPressed: onCancel, child: const Text('Cancel')),
                  const SizedBox(width: 20),
                  ElevatedButton(onPressed: onAdd, child: const Text('Create')),
                ],
              ))


            ],
          )
        ],
      ),
    );
  }
}
