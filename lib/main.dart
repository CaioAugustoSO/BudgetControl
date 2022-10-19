// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe

import 'dart:math';
import 'dart:io';

import 'package:budgetcontrol/components/chart.dart';
import 'package:budgetcontrol/components/transaction_form.dart';
import 'package:budgetcontrol/components/transaction_list.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';

main() => runApp(BudgetControlApp());

class BudgetControlApp extends StatelessWidget {
  const BudgetControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amber,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleSmall: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;
//filtra as transações recentes
  List<Transaction> get _recentTransactions {
    return _transactions
        .where((tr) => tr.date.isAfter(DateTime.now().subtract(
              Duration(days: 7),
            )))
        .toList();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appbar = AppBar(
      actions: [
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: Icon(Icons.add),
        ),
        if (isLandscape)
          IconButton(
              onPressed: () {
                setState(() {
                  _showChart = !_showChart;
                });
              },
              icon: Icon(_showChart ? Icons.list : Icons.show_chart))
      ],
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(fontSize: 20 * MediaQuery.of(context).textScaleFactor),
      ),
    );
    final availabeHeight = MediaQuery.of(context).size.height -
        appbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appbar,
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_showChart || !isLandscape)
                Container(
                  height: availabeHeight * (isLandscape ? 0.7 : 0.3),
                  child: Chart(recentTransaction: _recentTransactions),
                ),
              if (!_showChart || !isLandscape)
                Container(
                  height: availabeHeight * (isLandscape ? 1 : 0.8),
                  child: TransactionList(
                    transactions: _transactions,
                    onRemove: _removeTransaction,
                  ),
                )
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          Platform.isIOS ? null : FloatingActionButtonLocation.centerFloat,
    );
  }
}
