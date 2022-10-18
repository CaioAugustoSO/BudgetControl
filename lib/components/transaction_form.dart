// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm({super.key, required this.onSubmit});
  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  _submitForm() {
    final value = double.tryParse(_valueController.text) ?? 0.0;
    final title = _titleController.text;
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onSubmitted: (_) => _submitForm(),
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              onSubmitted: (_) => _submitForm(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: _valueController,
              decoration: InputDecoration(labelText: 'Valor(R\$)'),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma data selecionada'
                          : 'Data Selecionada: ${DateFormat('d/M/y').format(_selectedDate)}',
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple)),
                  child: Text('Nova Transação'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}