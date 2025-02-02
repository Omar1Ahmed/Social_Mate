import 'package:flutter/material.dart';

void onPressed({
  required GlobalKey<FormState> formKey,
  required BuildContext context,
  required TextEditingController titleController,
  required TextEditingController postOwnerController,
  required TextEditingController createdFromController,
  required TextEditingController createdToController,
  required TextEditingController sortedByItemController,
  required TextEditingController orderedByItemController,
}) {
  if (formKey.currentState!.validate()) {
    print('Form is valid');
    print('Title: ${titleController.text}');
    print('Post Owner: ${postOwnerController.text}');
    print('Created From: ${createdFromController.text}');
    print('Created To: ${createdToController.text}');
    print('Sorted By: ${sortedByItemController.text}');
    print('Sorted By: ${orderedByItemController.text}');
  } else {
    print('Form is invalid');
    print('Title: ${titleController.text}');
    print('Post Owner: ${postOwnerController.text}');
    print('Created From: ${createdFromController.text}');
    print('Created To: ${createdToController.text}');
    print('Sorted By: ${sortedByItemController.text}');
    print('Sorted By: ${orderedByItemController.text}');
  }
}
