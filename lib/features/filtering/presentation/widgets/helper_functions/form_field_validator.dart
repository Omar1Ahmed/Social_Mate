String? validateTextInput(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

String? validateDateRange(DateTime? fromDate, DateTime? toDate) {
  if (fromDate != null &&
      toDate != null &&
      toDate.isBefore(fromDate) &&
      fromDate != toDate) {
    return 'wrong date range';
  }
  return null; // Return null if the validation passes
}
