// ignore_for_file: import_of_legacy_library_into_null_safe, prefer_const_constructors

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {super.key, required this.transactions, required this.onRemove});
  final List<Transaction> transactions;

  final void Function(String) onRemove;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nenhuma transação cadastrada ainda use o "+"',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/espera.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : Container(
            height: 300,
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text('R\$${tr.value}'),
                        ),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    subtitle: Text(DateFormat('d MM y').format(tr.date)),
                    trailing: MediaQuery.of(context).size.width > 400
                        ? TextButton.icon(
                            onPressed: () => onRemove(tr.id),
                            icon: Icon(Icons.delete),
                            label: Text('Excluir'),
                            style: TextButton.styleFrom(primary: Colors.red),
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => onRemove(tr.id),
                          ),
                  ),
                );
              },
            ),
          );
  }
}
