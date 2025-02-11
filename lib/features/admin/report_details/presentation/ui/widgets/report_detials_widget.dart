import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/features/admin/report_details/presentation/ui/widgets/build_action_buttons_widget.dart';

import '../../../../../../core/shared/widgets/animation/slide_Transition__widget.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';

class ReportDetialsWidget extends StatelessWidget {
  final DeviceInfo info;
  const ReportDetialsWidget({super.key, required this.info});
  @override
  Widget build(BuildContext context) {
    return SlideTransitionWidget(
      child: Container(
        width: info.screenWidth * 0.9,
        padding: EdgeInsets.all(info.screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: info.screenWidth * 0.01,
              blurRadius: info.screenWidth * 0.02,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(info.screenWidth * 0.03),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: info.screenHeight * 0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Report details",
                style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.046),
              ),
              Divider(
                thickness: 2,
                height: info.screenHeight * 0.02,
                color: ColorsManager.blackColor.withOpacity(0.6),
              ),
              SizedBox(
                height: info.screenHeight * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: info.screenWidth * 0.4,
                    decoration: BoxDecoration(
                      color: ColorsManager.lightGreyColor,
                      borderRadius: BorderRadius.circular(info.screenWidth * 0.02),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: info.screenWidth * 0.01,
                          blurRadius: info.screenWidth * 0.02,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Spam',
                        style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.045),
                      ),
                    ),
                  ),
                  Container(
                    width: info.screenWidth * 0.4,
                    decoration: BoxDecoration(
                      color: ColorsManager.orangeColor,
                      borderRadius: BorderRadius.circular(info.screenWidth * 0.02),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: info.screenWidth * 0.01,
                          blurRadius: info.screenWidth * 0.02,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'pending',
                        style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.045),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: info.screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.lightGreyColor,
                      borderRadius: BorderRadius.circular(info.screenWidth * 0.02),
                    ),
                    child: Center(
                      child: Text(
                        'Reported By:Abdullah ',
                        style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.045),
                      ),
                    ),
                  ),
                  Text(
                    "2025-02-11",
                    style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04),
                  ),
                ],
              ),
              SizedBox(height: info.screenHeight * 0.02),
              Text(
                "Report Reason:",
                style: TextStyles.inter18Bold.copyWith(fontSize: info.screenWidth * 0.044),
              ),
              Divider(
                thickness: 2,
                height: info.screenHeight * 0.02,
                color: ColorsManager.blackColor.withOpacity(0.6),
              ),
              Text(
                "Sample reason for report here sample reason for report here sample reason for report here",
                style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04),
              ),
              SizedBox(
                height: info.screenHeight * 0.02,
              ),
              Text(
                "Actions",
                style: TextStyles.inter18Bold.copyWith(fontSize: info.screenWidth * 0.044),
              ),
              Divider(
                thickness: 2,
                height: info.screenHeight * 0.02,
                color: ColorsManager.blackColor.withOpacity(0.6),
              ),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Admin: ',
                          style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.04),
                        ),
                        TextSpan(
                          text: 'Abdullah Ahmed',
                          style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.045),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: info.screenWidth * 0.3,
                    decoration: BoxDecoration(
                      color: ColorsManager.redColor,
                      borderRadius: BorderRadius.circular(info.screenWidth * 0.01),
                    ),
                    child: Center(
                      child: Text(
                        "Rejected",
                        style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: info.screenHeight * 0.02),
              ActionButtonsWidget(info: info),
            ],
          ),
        ),
      ),
    );
  }
}
