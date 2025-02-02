// --> separate file for date picker helper functions
/* Note:
    - how the context is handled is new for me
    - the controller.text is handled automatically , but if you want to handle additional setstate 
    , you you onDateSelected property (onDateSelected?.call(); // Trigger the callback)
*/

import 'package:flutter/material.dart';

void showFromDatePicker({
  required Function(DateTime) onDateSelected,
  required BuildContext context,
  required TextEditingController controller,
  required DateTime firstDate,
  required DateTime lastDate,

}) {
  showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: firstDate,
    lastDate: lastDate,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(primary: Colors.blue),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        child: child!,
      );
    },
  ).then((value) {
    if (value != null) {
      controller.text = "${value.toLocal()}"
          .split(' ')[0]; // this handles the controller value in the UI
      //selectedFromDate = value;
    }
  });
}

void showToDatePicker({
  required Function(DateTime) onDateSelected,
  required BuildContext context,
  required TextEditingController controller,
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: firstDate,
    lastDate: lastDate,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(primary: Colors.blue),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        child: child!,
      );
    },
  ).then((value) {
    if (value != null) {
      controller.text = "${value.toLocal()}".split(' ')[0];
      onDateSelected(value);
    }
  });
}
