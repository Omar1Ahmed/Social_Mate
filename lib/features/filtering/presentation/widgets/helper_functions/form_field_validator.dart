import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? validateTextInput(
  String sortedByValue,
  TextEditingController titleController,
  TextEditingController postOwnerController,
  TextEditingController createdFromController,
  TextEditingController createdToController,
  TextEditingController orderedByController,
) {
  if ((sortedByValue.isEmpty) &&
      titleController.text.isEmpty &&
      postOwnerController.text.isEmpty &&
      createdFromController.text.isEmpty &&
      createdToController.text.isEmpty &&
      orderedByController.text.isEmpty) {
    return null;
  }
  if ((sortedByValue.isEmpty) && orderedByController.text.isNotEmpty) {
    return 'you neet to select a value here';
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
