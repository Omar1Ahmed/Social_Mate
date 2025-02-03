import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? validateTextInput(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

String? validateDateRange(DateTime? fromDate, DateTime? toDate,
    TextEditingController fromController, TextEditingController toController) {
  DateFormat format = DateFormat('yyyy-MM-dd');

  // Allow users to select only one date without error
  if (fromDate == null || toDate == null) {
    return null; // No validation needed if one of them is not selected
  }

  String fromDateFormatted = format.format(fromDate);
  String toDateFormatted = format.format(toDate);

  if (fromDateFormatted == toDateFormatted &&
      fromController.text.isNotEmpty &&
      toController.text.isNotEmpty) {
    return 'Cannot be the same';
  }

  if (toDate.isBefore(fromDate)) {
    return 'Wrong date range';
  }

  return null; // Return null if the validation passes
}
