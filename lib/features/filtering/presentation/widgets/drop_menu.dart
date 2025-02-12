import 'package:flutter/material.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';

class DropMenu extends StatelessWidget {
  final void Function(String?)? onSelected;
  final String menuLabel;
  final String selectedValue;
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
    this.onSelected,
    this.validator,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: validator,
      builder: (FormFieldState<String> field) {
        return Column(
          children: [
            // user shouldn't be able to type
            Container(
              height: screenHeight * 0.06,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.02,
              ),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.blackColor, width: 1),
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
              child: DropdownButton<String>(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                isExpanded: true,
                value: selectedValue,
                onChanged: onSelected,
                focusNode: sortedByNode,
                style: TextStyles.inter16RegularBlack,
                hint: Text(
                  'Select sorting type',
                  style: TextStyles.inter16RegularBlack,
                ),
                items: sortedByEntries.map((entry) {
                  return DropdownMenuItem<String>(
                    value: entry.value,
                    child: Text(
                      entry.label,
                      style: TextStyles.inter16RegularBlack,
                    ),
                  );
                }).toList(),
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                ),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(16),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                menuMaxHeight: screenHeight * 0.2,
              ),
            ),
            if (field.hasError)
              Text(
                field.errorText ?? '',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
          ],
        );
      },
    );
  }
}
