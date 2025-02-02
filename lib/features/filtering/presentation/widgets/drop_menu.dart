import 'package:flutter/material.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';

class DropMenu extends StatelessWidget {
  final void Function(String?)? onSelected;
  final String menuLabel;
  final List<DropdownMenuEntry<String>> sortedByEntries;
  final String initialSelection;
  final double screenWidth;
  final double screenHeight;
  final FocusNode sortedByNode;
  final TextEditingController menuItemController;
  const DropMenu({
    super.key,
    required this.sortedByNode,
    required this.menuItemController,
    required this.screenWidth,
    required this.screenHeight,
    required this.sortedByEntries,
    required this.initialSelection,
    required this.menuLabel,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownMenu(
          onSelected: onSelected,
          initialSelection: initialSelection,
          requestFocusOnTap: true,
          focusNode: sortedByNode,
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: ColorsManager.primaryColor,
                width: 1,
              ),
            ),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black,
                width: 2,
              ),
            ),
          ),
          controller: menuItemController,
          alignmentOffset: Offset(-12, 30),
          hintText: 'Select sorting type',
          textStyle: TextStyles.inter16RegularBlack,
          label: Text(
            menuLabel,
            style: TextStyles.inter18MediumBlack,
          ),
          width: screenWidth * 0.9,
          menuStyle: MenuStyle(
            side: WidgetStatePropertyAll(BorderSide(
              color: ColorsManager.primaryColor,
            )),
            elevation: WidgetStatePropertyAll(3),
            alignment: Alignment.centerLeft,
            minimumSize: WidgetStatePropertyAll(Size(
              screenWidth * 0.3,
              screenHeight * 0.2,
            )),
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            )),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 5),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          dropdownMenuEntries: sortedByEntries),
    );
  }
}
