import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';

import '../../../../../../core/theming/colors.dart';

class ShowReportDialogWidget extends StatelessWidget {
  const ShowReportDialogWidget({super.key, required this.deviceInfo});
  final DeviceInfo deviceInfo;

  @override
  Widget build(BuildContext context) {
    int selectedCategory = -1;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
      ),
      elevation: 8.0,
      child: SingleChildScrollView(
        // Add this to make the content scrollable
        child: Container(
          width: deviceInfo.localWidth * 0.8,
          padding: EdgeInsets.all(deviceInfo.localWidth * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "Report the Post",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceInfo.screenWidth * 0.05,
                  color: ColorsManager.blackColor,
                ),
              ),
              SizedBox(height: deviceInfo.localHeight * 0.02),

              // Report Category
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
                      4,
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
                                  [
                                    "Harmful",
                                    "Inappropriate",
                                    "Spam",
                                    "Other"
                                  ][index],
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

              // Report Reason
              Text(
                "Provide a Reason",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: deviceInfo.screenWidth * 0.04,
                  color: ColorsManager.greyColor,
                ),
              ),
              SizedBox(height: deviceInfo.localHeight * 0.01),
              TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorsManager.lightGreyColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter your reason...",
                  hintStyle: TextStyle(
                    fontSize: deviceInfo.screenWidth * 0.04,
                    color: ColorsManager.greyColor,
                  ),
                ),
              ),
              SizedBox(height: deviceInfo.localHeight * 0.03),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
