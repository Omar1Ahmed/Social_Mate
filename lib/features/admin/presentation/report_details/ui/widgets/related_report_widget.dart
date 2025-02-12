import 'package:flutter/material.dart';

import '../../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';

class RelatedReportWidget extends StatelessWidget {
  const RelatedReportWidget({
    super.key,
    required this.deviceInfo,
    required this.fullName,
    required this.createdAt,
    required this.state,
  });
  final DeviceInfo deviceInfo;
  final String fullName;
  final String createdAt;
  final String state;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: deviceInfo.screenWidth * 0.9,
        padding: EdgeInsets.all(deviceInfo.screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.03),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: deviceInfo.screenWidth * 0.01,
              blurRadius: deviceInfo.screenWidth * 0.02,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              fullName,
              style: TextStyles.inter18BoldBlack.copyWith(fontSize: deviceInfo.screenWidth * 0.03),
            ),
            Spacer(),
            Container(
              width: deviceInfo.screenWidth * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.03),
                color: ColorsManager.orangeColor,
              ),
              child: Center(
                child: Text(
                  state,
                  style: TextStyles.inter18BoldBlack.copyWith(fontSize: deviceInfo.screenWidth * 0.03),
                ),
              ),
            ),
            Spacer(),
            Text(
              createdAt,
              style: TextStyles.inter18BoldBlack.copyWith(fontSize: deviceInfo.screenWidth * 0.03),
            ),
          ],
        ),
      ),
    );
  }
}
