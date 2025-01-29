import 'package:flutter/material.dart';

import '../../../../../theming/colors.dart';
import '../../../../../theming/styles.dart';

// ignore: must_be_immutable
class CreatePostWidget extends StatelessWidget {
  CreatePostWidget({super.key, this.deviceInfo});
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController contentTextEditingController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  final deviceInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceInfo.localWidth * 0.9,
      height: deviceInfo.localHeight * 0.33,
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: ColorsManager.primaryColor.withOpacity(0.1),
        // ignore: deprecated_member_use
        border: Border.all(color: ColorsManager.primaryColor.withOpacity(1)),
        borderRadius: BorderRadius.circular(10),
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
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
