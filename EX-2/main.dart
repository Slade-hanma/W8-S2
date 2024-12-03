//lib\EX-1-2-3\main.dart

import 'package:flutter/material.dart';

import 'screens/expenses/expenses.dart';
 

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Expenses(),
    ),
  );
}
