import 'package:flutter/material.dart';
import 'package:social_media/core/theming/styles.dart';

/// should be statless
class FormTextInput extends StatefulWidget {
  final String label;
  final String hintText;
  final FocusNode focusNode;
  final FocusNode nextNode;
  final TextEditingController controller;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  const FormTextInput({
    super.key,
    required this.label,
    required this.hintText,
    required this.focusNode,
    required this.nextNode,
    required this.controller,
    this.onTap,
    this.validator,
  });

  @override
  State<FormTextInput> createState() => _FormTextInputState();
}

class _FormTextInputState extends State<FormTextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        focusNode: widget.focusNode,
        minLines: 1,
        decoration:
            formInputStyle(hintText: widget.hintText, label: widget.label),
        onTap: widget.onTap,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(widget.nextNode);
        },
      ),
    );
  }
}
