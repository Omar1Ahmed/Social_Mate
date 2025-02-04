import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import '../../../../../../core/theming/colors.dart';

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({
    super.key,
    required this.deviceInfo,
    required this.title,
    required this.fields,
    required this.actions,
  });

  final DeviceInfo deviceInfo;
  final String title; // Title of the dialog (e.g., "Report the Post", "Create Post")
  final List<Widget> fields; // List of input fields (e.g., TextFields, RadioButtons)
  final List<Widget> actions; // List of action buttons (e.g., Report, Cancel)

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
      ),
      elevation: 8.0,
      child: SingleChildScrollView(
        child: Container(
          width: deviceInfo.localWidth * 0.8,
          padding: EdgeInsets.all(deviceInfo.localWidth * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: deviceInfo.screenWidth * 0.05,
                  color: ColorsManager.blackColor,
                ),
              ),
              SizedBox(height: deviceInfo.localHeight * 0.02),

              // Input Fields
              ...fields,

              SizedBox(height: deviceInfo.localHeight * 0.03),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions,
              ),
            ],
          ),
        ),
      ),
    );
  }
}