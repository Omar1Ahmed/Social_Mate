import 'package:flutter/material.dart';

import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';

// ignore: must_be_immutable
class CreatePostWidget extends StatelessWidget {
  CreatePostWidget({super.key, this.deviceInfo});
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController contentTextEditingController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  final deviceInfo;

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success', style: TextStyles.inter18Bold),
          content: Text('Your post has been created successfully!', style: TextStyles.inter18Regular),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the success dialog
              },
              child: Text('OK', style: TextStyles.inter14RegularBlue),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceInfo.localWidth * 0.9,
      height: deviceInfo.localHeight * 0.33,
      decoration: BoxDecoration(
        color: ColorsManager.lightblue,
        border: Border.all(color: ColorsManager.primaryColor.withOpacity(1)),
        borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.05),
      ),
      child: Padding(
        padding: EdgeInsets.all(deviceInfo.localWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyles.inter14RegularBlue.copyWith(fontSize: deviceInfo.localWidth * 0.04),
            ),
            SizedBox(height: deviceInfo.localHeight * 0.01),
            SizedBox(
              height: deviceInfo.localHeight * 0.046,
              width: deviceInfo.localWidth * 0.8,
              child: TextField(
                controller: titleTextEditingController,
                cursorColor: ColorsManager.primaryColor,
                decoration: TextFieldStyles.inputDecorationTitleFiled,
              ),
            ),
            SizedBox(height: deviceInfo.localHeight * 0.01),
            Text(
              'Content',
              style: TextStyles.inter14RegularBlue.copyWith(fontSize: deviceInfo.localWidth * 0.04),
            ),
            SizedBox(height: deviceInfo.localHeight * 0.01),
            SizedBox(
              height: deviceInfo.localHeight * 0.08,
              width: deviceInfo.localWidth * 0.8,
              child: TextField(
                controller: contentTextEditingController,
                maxLines: 5,
                cursorColor: ColorsManager.primaryColor,
                decoration: TextFieldStyles.inputDecorationContentFiled,
              ),
            ),
            SizedBox(height: deviceInfo.localHeight * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Image.asset(
                    'assets/images/create_post_icon.png',
                    width: deviceInfo.localWidth * 0.09,
                    height: deviceInfo.localWidth * 0.09,
                  ),
                  iconSize: deviceInfo.localWidth * 0.1,
                  onPressed: () {
                    _showSuccessDialog(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
