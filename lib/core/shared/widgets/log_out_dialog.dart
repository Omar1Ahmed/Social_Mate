import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';

void logOutDialog(BuildContext context, DeviceInfo deviceInfo) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: ColorsManager.whiteColor,
      title: Text(
        'Confirm Logout',
        style: TextStyles.inter18BoldBlack.copyWith(fontSize: deviceInfo.screenWidth * 0.05),
      ),
      content: Text(
        'Are you sure you want to log out?',
        style: TextStyles.inter18Regularblack.copyWith(fontSize: deviceInfo.screenWidth * 0.04),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), // Cancel action
          child: Text(
            'Cancel',
            style: TextStyles.inter18Regularblack.copyWith(color: ColorsManager.primaryColor),
          ),
        ),
        TextButton(
          onPressed: () {
            getIt<userMainDetailsCubit>().logOut();
            context.pushNamedAndRemoveUntil(Routes.AuthScreen, predicate: (route) => false);
          },
          child: Text(
            'Logout',
            style: TextStyles.inter18Regularblack.copyWith(color: ColorsManager.redColor),
          ),
        ),
      ],
    ),
  );
}
