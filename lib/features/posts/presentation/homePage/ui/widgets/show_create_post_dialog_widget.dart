import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/di/di.dart';
import '../../../../../../core/theming/colors.dart';
import '../../logic/cubit/home_cubit_cubit.dart';
import 'custom_dialog_widget.dart';

class ShowCreatePostDialogWidget extends StatelessWidget {
  ShowCreatePostDialogWidget({super.key, required this.deviceInfo});
  final DeviceInfo deviceInfo;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      deviceInfo: deviceInfo,
      title: "Create Post",
      fields: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(
            labelText: "Title",
            filled: true,
            fillColor: ColorsManager.lightGreyColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
              borderSide: BorderSide(
                  color: ColorsManager.greyColor,
                  width: deviceInfo.localWidth * 0.0015
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
              borderSide: BorderSide(
                  color: ColorsManager.greyColor,
                  width: deviceInfo.localWidth * 0.0015
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
              borderSide: BorderSide(
                  color: ColorsManager.primaryColor,
                  width: deviceInfo.localWidth * 0.0015
              ),
            )
          ),
        ),
        SizedBox(height: deviceInfo.localHeight * 0.02),
        TextField(
          controller: contentController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: "Content",
            filled: true,
            fillColor: ColorsManager.lightGreyColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
                borderSide: BorderSide(
                    color: ColorsManager.greyColor,
                    width: deviceInfo.localWidth * 0.0015
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
                borderSide: BorderSide(
                    color: ColorsManager.greyColor,
                    width: deviceInfo.localWidth * 0.0015
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
                borderSide: BorderSide(
                    color: ColorsManager.primaryColor,
                    width: deviceInfo.localWidth * 0.0015
                ),
              )
          ),
        ),
      ],
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            titleController.clear();
            contentController.clear();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ColorsManager.greyColor.withOpacity(0.2)),
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
        SizedBox(width: deviceInfo.localWidth * 0.02),
        TextButton(
          onPressed: () {
            if (titleController.text.isNotEmpty && contentController.text.isNotEmpty) {
              Navigator.pop(context);
              getIt.get<HomeCubit>().createPost(titleController.text, contentController.text);
              titleController.clear();
              contentController.clear();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Post created successfully!")),
              );
            } else if (titleController.text.length < 25) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Title must be at least 25 characters.")),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please fill in all fields.")),
              );
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(ColorsManager.primaryColor),
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
            "Submit",
            style: TextStyle(
              color: Colors.white,
              fontSize: deviceInfo.screenWidth * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
