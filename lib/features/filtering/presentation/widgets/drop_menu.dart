import 'package:flutter/material.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';

class DropMenu extends StatelessWidget {
  final void Function(String?)? onSelected;
  final String menuLabel;
  final List<DropdownMenuEntry<String>> sortedByEntries;
final String? Function(String?)? validator;
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
    required this.menuLabel,
    this.onSelected, this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FormField(
        validator : validator,
        builder: (FormFieldState<String> field) { 
        return Column(
          children: [
            DropdownMenu(
                onSelected: onSelected,
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
            if (field.hasError)
              Text(
                field.errorText ?? '',
                style: TextStyle(color: Colors.red , fontSize: 12),
              ),
          ],
        );
         },
      ),
    );
  }
}
