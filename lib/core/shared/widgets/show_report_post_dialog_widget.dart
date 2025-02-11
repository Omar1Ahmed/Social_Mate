import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/admin/data/models/main_report_model.dart';
import '../../../features/posts/presentation/homePage/logic/cubit/home_cubit_cubit.dart';
import '../../../features/posts/presentation/homePage/ui/widgets/build_error_widget.dart';
import '../../Responsive/Models/device_info.dart';
import '../../theming/colors.dart';
import 'custom_dialog_widget.dart';

// ignore: must_be_immutable
class ShowReportPostDialogWidget extends StatelessWidget {
  ShowReportPostDialogWidget({super.key, required this.deviceInfo, this.onPressedReport});
  final DeviceInfo deviceInfo;
  int selectedCategory = -1;
  final TextEditingController reasonController = TextEditingController();
  final Function(int categoryId, String reason)? onPressedReport;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        print("state $state");
        List<Category> categories = [];
        if (state is LoadedReportCategories) {
          categories = state.categories;
          print("categories${categories[2].titleEn.toString()}");
          return CustomDialogWidget(
            deviceInfo: deviceInfo,
            title: "Report the Post",
            fields: [
              Text(
                "Select a Category",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: deviceInfo.screenWidth * 0.04,
                  color: ColorsManager.greyColor,
                ),
              ),
              SizedBox(height: deviceInfo.localHeight * 0.01),
              StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    children: List.generate(
                      categories.length,
                      (index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: deviceInfo.localHeight * 0.01),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedCategory = index;
                            });
                          },
                          child: Row(
                            children: [
                              Radio<int>(
                                value: index,
                                groupValue: selectedCategory,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCategory = value!;
                                  });
                                },
                                activeColor: ColorsManager.primaryColor,
                              ),
                              SizedBox(width: deviceInfo.localWidth * 0.02),
                              Expanded(
                                child: Text(
                                  categories[index].titleEn.toString(),
                                  style: TextStyle(
                                    fontSize: deviceInfo.screenWidth * 0.04,
                                    color: ColorsManager.blackColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: deviceInfo.localHeight * 0.02),
              TextField(
                controller: reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Provide a Reason",
                  filled: true,
                  fillColor: ColorsManager.lightGreyColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
                    borderSide: BorderSide(color: ColorsManager.greyColor, width: deviceInfo.localWidth * 0.0015),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
                    borderSide: BorderSide(color: ColorsManager.primaryColor, width: deviceInfo.localWidth * 0.002),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
                    borderSide: BorderSide(color: ColorsManager.greyColor, width: deviceInfo.localWidth * 0.0015),
                  ),
                ),
              ),
            ],
            actions: [
              TextButton(
                onPressed: () => onPressedReport!(categories[selectedCategory].id, reasonController.text),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ColorsManager.redColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: deviceInfo.localWidth * 0.1,
                      vertical: deviceInfo.localHeight * 0.015,
                    ),
                  ),
                ),
                child: Text(
                  "Report",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: deviceInfo.screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: deviceInfo.localWidth * 0.02),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(ColorsManager.greyColor.withOpacity(0.3)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: deviceInfo.localWidth * 0.1,
                      vertical: deviceInfo.localHeight * 0.015,
                    ),
                  ),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: ColorsManager.blackColor,
                    fontSize: deviceInfo.screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        } else if (state is PostReportedLoading) {
          CircularProgressIndicator();
        }
        return BuildErrorWidget(deviceInfo: deviceInfo);
      },
    );
  }
}
