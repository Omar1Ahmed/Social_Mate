import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';

import '../../theming/colors.dart';

class HeaderWidget extends StatelessWidget {
  final DeviceInfo info;
  final VoidCallback onBackPressed;
  final String titleImageAsset;
  final List<Widget> extraButtons;

  const HeaderWidget({
    super.key,
    required this.info,
    required this.onBackPressed,
    required this.titleImageAsset,
    this.extraButtons = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: info.screenWidth * 0.02,
        vertical: info.screenHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: info.screenWidth * 0.02,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: info.screenWidth * 0.08,
              color: ColorsManager.primaryColor,
            ),
            onPressed: onBackPressed, 
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.all(info.screenWidth * 0.01),
              backgroundColor: ColorsManager.lightGreyColor,
              shadowColor: Colors.transparent,
            ),
          ),

          Image.asset(
            titleImageAsset,
            width: info.screenWidth * 0.48,
            height: info.screenHeight * 0.06,
            fit: BoxFit.contain,
          ),

          // Extra Buttons (if any)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: extraButtons,
          ),
        ],
      ),
    );
  }
}
