import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/features/filtering/presentation/widgets/filtering_button.dart';
import 'package:social_media/features/filtering/presentation/widgets/form_text_input.dart';
import 'package:social_media/features/filtering/presentation/widgets/helper_functions/date_picker_helper.dart';
import 'package:social_media/features/filtering/presentation/widgets/helper_functions/filtering_button_function.dart';
import 'package:social_media/features/filtering/presentation/widgets/helper_functions/form_field_validator.dart';
import 'package:social_media/features/filtering/presentation/widgets/drop_menu.dart';

class FilteringTile extends StatefulWidget {
  const FilteringTile({super.key});

  @override
  State<FilteringTile> createState() => _FilteringTileState();
}

class _FilteringTileState extends State<FilteringTile> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController postOwnerController = TextEditingController();
  final TextEditingController createdFromController = TextEditingController();
  final TextEditingController createdToController = TextEditingController();
  final TextEditingController sortedByItemController = TextEditingController();
  final TextEditingController orderedByItemController = TextEditingController();
  final FocusNode titleNode = FocusNode();
  final FocusNode postOwnerNode = FocusNode();
  final FocusNode createdFromNode = FocusNode();
  final FocusNode createdToNode = FocusNode();
  final FocusNode sortedByNode = FocusNode();
  final FocusNode orderedByNode = FocusNode();
  final FocusNode noNode = FocusNode();
  final DateTime firstDate = DateTime(2021, 1, 1);
  final DateTime lastDate = DateTime(2026, 1, 1);
  late DateTime selectedFromDate = DateTime.now();
  late DateTime selectedToDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    postOwnerController.dispose();
    createdFromController.dispose();
    createdToController.dispose();
    sortedByItemController.dispose();
    titleNode.dispose();
    postOwnerNode.dispose();
    createdFromNode.dispose();
    createdToNode.dispose();
    sortedByNode.dispose();
    noNode.dispose();
    super.dispose();
  }

  void Function() sortedByOnSelected(String? value) {
    FocusScope.of(context).requestFocus(orderedByNode);
    return () {};
  }

  void Function() orderedByOnSelected(String? value) {
    FocusScope.of(context).unfocus();
    return () {};
  }

  void _handleFromDateSelected(DateTime newDate) {
    setState(() {
      selectedFromDate = newDate;
    });
  }

  void _handleToDateSelected(DateTime newDate) {
    setState(() {
      selectedToDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      return Container(
        height: deviceInfo.screenHeight * 0.55,
        width: deviceInfo.screenWidth,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ColorsManager.primaryColor,
            width: 1,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: IntrinsicHeight(
                  child: FormTextInput(
                    nextNode: postOwnerNode,
                    label: 'Title',
                    hintText: 'Enter post title',
                    focusNode: titleNode,
                    controller: titleController,
                    validator: validateTextInput,
                  ),
                ),
              ),
              Flexible(
                child: FormTextInput(
                  controller: postOwnerController,
                  nextNode: createdFromNode,
                  focusNode: postOwnerNode,
                  label: 'Post Owner',
                  hintText: 'Enter post owner',
                  validator: validateTextInput,
                ),
              ),
              SizedBox(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FormTextInput(
                        label: 'Created From',
                        hintText: selectedFromDate.toString(),
                        focusNode: createdFromNode,
                        nextNode: createdToNode,
                        controller: createdFromController,
                        onTap: () {
                          showFromDatePicker(
                            onDateSelected: _handleFromDateSelected,
                            context: context,
                            controller: createdFromController,
                            firstDate: firstDate,
                            lastDate: lastDate,
                          );
                        },
                        validator: (value) {
                          return validateDateRange(
                              selectedFromDate,
                              selectedToDate,
                              createdFromController,
                              createdToController);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: FormTextInput(
                        label: 'Created To',
                        hintText: selectedToDate.toString(),
                        focusNode: createdToNode,
                        nextNode: sortedByNode,
                        controller: createdToController,
                        onTap: () {
                          showToDatePicker(
                            context: context,
                            controller: createdToController,
                            firstDate: firstDate,
                            lastDate: lastDate,
                            onDateSelected: _handleToDateSelected,
                          );
                        },
                        validator: (value) {
                          return validateDateRange(
                              selectedFromDate,
                              selectedToDate,
                              createdFromController,
                              createdToController);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              DropMenu(
                onSelected: sortedByOnSelected,
                menuLabel: 'Sorted By',
                initialSelection: 'TITLE',
                sortedByNode: sortedByNode,
                menuItemController: sortedByItemController,
                screenWidth: deviceInfo.screenWidth,
                screenHeight: deviceInfo.screenHeight,
                sortedByEntries: [
                  DropdownMenuEntry(value: 'TITLE', label: 'Title'),
                  DropdownMenuEntry(value: 'POST_OWNER', label: 'Post owner'),
                  DropdownMenuEntry(
                      value: 'CREATION_DATE', label: 'Creation date'),
                ],
              ),
              DropMenu(
                onSelected: orderedByOnSelected,
                menuLabel: 'Order Direction',
                initialSelection: 'ASC',
                sortedByNode: orderedByNode,
                menuItemController: orderedByItemController,
                screenWidth: deviceInfo.screenWidth,
                screenHeight: deviceInfo.screenHeight,
                sortedByEntries: [
                  DropdownMenuEntry(value: 'ASC', label: 'Ascending'),
                  DropdownMenuEntry(value: 'DESC', label: 'Descending'),
                ],
              ),
              FilteringButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  onPressed(
                      formKey: _formKey,
                      context: context,
                      titleController: titleController,
                      postOwnerController: postOwnerController,
                      createdFromController: createdFromController,
                      createdToController: createdToController,
                      sortedByItemController: sortedByItemController,
                      orderedByItemController: orderedByItemController);
                },
                screenWidth: deviceInfo.screenWidth,
                screenHeight: deviceInfo.screenHeight,
              ),
            ],
          ),
        ),
      );
    });
  }
}
