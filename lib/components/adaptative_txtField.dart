import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  const AdaptativeTextField(
      {super.key,
      required this.onSubmitted,
      required this.controller,
      this.keyboardtyppe = TextInputType.text,
      required this.label});

  final String label;

  final void Function(String) onSubmitted;

  final TextEditingController controller;

  final TextInputType keyboardtyppe;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              controller: controller,
              onSubmitted: onSubmitted,
              keyboardType: keyboardtyppe,
              placeholder: label,
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            onSubmitted: onSubmitted,
            controller: controller,
            keyboardType: keyboardtyppe,
            decoration: InputDecoration(labelText: label),
          );
  }
}
