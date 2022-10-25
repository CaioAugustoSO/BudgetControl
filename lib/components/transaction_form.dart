// ignore_for_file: prefer_const_constructors
import 'adaptative_datepicker.dart';
import 'adaptative_txtField.dart';

import 'package:flutter/material.dart';

import 'adaptative_button.dart';

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

  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextField(
                onSubmitted: (_) => _submitForm(),
                controller: _titleController,
                label: 'Título',
              ),
              AdaptativeTextField(
                onSubmitted: (_) => _submitForm(),
                keyboardtyppe: TextInputType.numberWithOptions(decimal: true),
                controller: _valueController,
                label: 'Valor(R\$)',
              ),
              AdpatativeDatePicker(
                  selectedDate: _selectedDate,
                  onDateChange: (newDate) {
                    setState(() {
                      _selectedDate = newDate;
                    });
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                      label: 'Nova Transação', onPressed: _submitForm)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
