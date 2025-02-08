import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/SharedPref/SharedPrefKeys.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtered_users/filtered_users_cubit.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtering_cubit.dart';
import 'package:social_media/features/filtering/presentation/cubit/sharing_data/sharing_data_cubit.dart';
import 'package:social_media/features/filtering/presentation/widgets/filtering_button.dart';
import 'package:social_media/features/filtering/presentation/widgets/form_text_input.dart';
import 'package:social_media/features/filtering/presentation/widgets/helper_functions/date_picker_helper.dart';
import 'package:social_media/features/filtering/presentation/widgets/helper_functions/form_field_validator.dart';
import 'package:social_media/features/filtering/presentation/widgets/drop_menu.dart';
import 'package:social_media/features/filtering/presentation/widgets/post_owner_dialog.dart';

class FilteringTile extends StatefulWidget {
  final FilteringCubit filteringCubit;
  final SharingDataCubit sharingDataCubit;
  final FilteredUsersCubit filteredUsersCubit;
  const FilteringTile(
      {super.key,
      required this.filteringCubit,
      required this.sharingDataCubit,
      required this.filteredUsersCubit});

  @override
  State<FilteringTile> createState() => _FilteringTileState();
}

class _FilteringTileState extends State<FilteringTile> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController postOwnerController = TextEditingController();
  final TextEditingController dialogeController = TextEditingController();
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
  DateTime? selectedFromDate = DateTime.now();
  DateTime? selectedToDate = DateTime.now();
  late String sortedByValue = '';
  late String orderedByValue = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late Map<String, dynamic> queryParameters;
  late FilteringCubit filteringCubit;

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

  @override
  void initState() {
    filteringCubit = widget.filteringCubit;
    super.initState();
  }

  void Function() sortedByOnSelected(String? value) {
    FocusScope.of(context).requestFocus(orderedByNode);
    sortedByValue = value ?? 'TITLE';
    return () {};
  }

  void Function() orderedByOnSelected(String? value) {
    FocusScope.of(context).unfocus();
    orderedByValue = value ?? 'ASC';

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

  void _onFilterButtonPressed() {
    FocusScope.of(context).unfocus();
    final _sharedPrefHelper = getIt<SharedPrefHelper>();
    final tokenFromCache = _sharedPrefHelper.getString(SharedPrefKeys.saveKey);
    final token =
        context.read<userMainDetailsCubit>().state.token ?? tokenFromCache;
    print(token);
    if (_formKey.currentState!.validate()) {
      queryParameters = {
        if (titleController.text.isNotEmpty) 'title': titleController.text,
        if (postOwnerController.text.isNotEmpty)
          'createdById': postOwnerController.text,
        if (sortedByValue.isNotEmpty) 'orderBy': sortedByValue,
        if (createdFromController.text.isNotEmpty)
          'createdOnFrom': createdFromController.text,
        if (createdToController.text.isNotEmpty)
          'createdOnTo': createdToController.text,
        if (orderedByValue.isNotEmpty) 'orderDir': orderedByValue,
        // 'pageOffset': 0, // Keep mandatory values
        // 'pageSize': 10, // Keep mandatory values
      };
      context.read<SharingDataCubit>().updateQueryParams(queryParameters);
      context.read<SharingDataCubit>().updatePosts([]);
      print('Query Parameters: $queryParameters');
      filteringCubit.getFilteredPosts(
          queryParameters: queryParameters, token: token!);
      print('Form is valid');
      print('Title: ${titleController.text}');
      print('Post Owner: ${postOwnerController.text}');
      print('Created From: ${createdFromController.text}');
      print('Created To: ${createdToController.text}');
      print('Sorted By: $sortedByValue');
      print('Ordered By: $orderedByValue');
    } else {
      print('Form is invalid');
    }
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
                    onTap: () => showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: PostOwnerDialog(
                              context: context,
                              width: deviceInfo.screenWidth * 0.9,
                              height: deviceInfo.screenHeight * 0.5,
                              filteredUsersCubit: widget.filteredUsersCubit,
                              parentController: postOwnerController,
                              dialogController: dialogeController,
                            ),
                          );
                        })),
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
                        hintText: selectedFromDate != null
                            ? selectedFromDate.toString().split(' ')[0]
                            : 'Select a date',
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
                        hintText: selectedToDate != null
                            ? selectedToDate.toString().split(' ')[0]
                            : 'Select a date',
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
                onPressed: _onFilterButtonPressed,
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
