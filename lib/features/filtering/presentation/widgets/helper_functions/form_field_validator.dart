import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? validateTextInput(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

String? validateDateRange(DateTime fromDate, DateTime toDate,
    TextEditingController fromController, TextEditingController toController) {
  DateFormat format = DateFormat('yyyy-MM-dd');
  String fromDateFormatted = format.format(fromDate);
  String toDateFormatted = format.format(toDate);

  if (fromController.text.isEmpty || toController.text.isEmpty) {
    return 'Please select a date';
  }
  if (fromDateFormatted == toDateFormatted) {
    return 'cannot be the same';
  }

  if (toDate.isBefore(fromDate)) {
    return 'wrong date range';
  }
  return null; // Return null if the validation passes
}
