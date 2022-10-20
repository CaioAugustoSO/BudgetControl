import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class AdpatativeDatePicker extends StatelessWidget {
  const AdpatativeDatePicker(
      {super.key, required this.selectedDate, required this.onDateChange});

  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  @override
  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChange(pickedDate);
    });
  }

  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              onDateTimeChanged: onDateChange,
              mode: CupertinoDatePickerMode.date,
              maximumDate: DateTime.now(),
              minimumDate: DateTime(2019),
              initialDateTime: DateTime.now(),
            ),
          )
        : Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? 'Nenhuma data selecionada'
                        : 'Data Selecionada: ${DateFormat('d/M/y').format(selectedDate)}',
                  ),
                ),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: Text(
                    'Selecionar Data',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
