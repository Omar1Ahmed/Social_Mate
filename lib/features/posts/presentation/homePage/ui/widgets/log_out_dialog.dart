import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/features/authentication/presentation/logic/remember_me_logic/save_and_remove_functions.dart';

void logOutDialog(BuildContext context, DeviceInfo deviceInfo) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Confirm Logout',
        style: TextStyles.inter18BoldBlack
            .copyWith(fontSize: deviceInfo.screenWidth * 0.05),
      ),
      content: Text(
        'Are you sure you want to log out?',
        style: TextStyles.inter18Regularblack
            .copyWith(fontSize: deviceInfo.screenWidth * 0.04),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Cancel action
          child: Text(
            'Cancel',
            style: TextStyles.inter18Regularblack
                .copyWith(color: ColorsManager.primaryColor),
          ),
        ),
        TextButton(
          onPressed: () {
            logout();
            Navigator.pushReplacementNamed(context, Routes.AuthScreen);
          },
          child: Text(
            'Delete',
            style: TextStyles.inter18Regularblack
                .copyWith(color: ColorsManager.redColor),
          ),
        ),
      ],
    ),
  );
}
