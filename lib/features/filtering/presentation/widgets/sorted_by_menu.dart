import 'package:flutter/material.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';


class SortedByMenu extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final FocusNode sortedByNode;
  final TextEditingController sortedByItemController;
  const SortedByMenu({
    super.key,
    required this.sortedByNode,
    required this.sortedByItemController,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownMenu(
          initialSelection: 'Latest',
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
          controller: sortedByItemController,
          alignmentOffset: Offset(-12, 30),
          hintText: 'Select sorting type',
          textStyle: TextStyles.inter16RegularBlack,
          label: Text(
            'Sorted By',
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
            fixedSize: WidgetStatePropertyAll(Size(
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
          dropdownMenuEntries: <DropdownMenuEntry<String>>[
            DropdownMenuEntry(
              value: 'Latest',
              label: 'Latest',
            ),
            DropdownMenuEntry(
              value: 'A to Z',
              label: 'A to Z',
            ),
            DropdownMenuEntry(
              value: 'Z to A',
              label: 'Z to A',
            ),
          ]),
    );
  }
}
