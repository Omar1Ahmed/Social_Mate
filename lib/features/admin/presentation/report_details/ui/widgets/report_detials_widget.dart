import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/features/admin/presentation/report_details/ui/widgets/build_action_buttons_widget.dart';
import '../../../../../../core/shared/widgets/Shimmer/ShimmerStyle.dart';
import '../../../../../../core/shared/widgets/animation/slide_Transition__widget.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';

// Assuming customShimmer is in the same file or imported
class ReportDetialsWidget extends StatelessWidget {
  final DeviceInfo info;
  final String category;
  final String status;
  final String reportedBy;
  final String reportReason;
  final String createdOn;
  final String? lastModifiedOn;
  final String lastModifiedBy;
  final bool isLoading; // New parameter to control shimmer effect

  const ReportDetialsWidget({
    super.key,
    required this.info,
    required this.category,
    required this.status,
    required this.reportedBy,
    required this.reportReason,
    required this.createdOn,
    this.lastModifiedOn,
    required this.lastModifiedBy,
    this.isLoading = false, // Default value is false
  });

  @override
  Widget build(BuildContext context) {
    // Wrap with shimmer only if isLoading is true
    Widget child = Container(
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
                      category,
                      style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.04),
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
                      status,
                      style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.04),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: info.screenHeight * 0.02),
            Container(
              width: info.screenWidth * 0.75,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: ColorsManager.lightGreyColor,
                borderRadius: BorderRadius.circular(info.screenWidth * 0.02),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: info.screenWidth * 0.02),
                child: Text(
                  'Reported By: $reportedBy',
                  style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04),
                ),
              ),
            ),
            SizedBox(height: info.screenHeight * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: info.screenWidth * 0.02),
              child: Text(
                "Reported On: $createdOn",
                style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04),
              ),
            ),
            SizedBox(height: info.screenHeight * 0.01),
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
              reportReason,
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
            lastModifiedBy.isEmpty
                ? Container(
                    width: info.screenWidth * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(info.screenWidth * 0.01),
                    ),
                    child: Text(
                      "No Action Taken yet",
                      style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04),
                    ),
                  )
                : Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Admin: ',
                              style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.04),
                            ),
                            TextSpan(
                              text: lastModifiedBy,
                              style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.045),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: info.screenWidth * 0.3,
                        decoration: BoxDecoration(
                          color: status == "Pending" ? ColorsManager.orangeColor : ColorsManager.redColor,
                          borderRadius: BorderRadius.circular(info.screenWidth * 0.01),
                        ),
                        child: Center(
                          child: Text(
                            status,
                            style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04),
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: info.screenHeight * 0.02),
            lastModifiedBy.isEmpty ? Container() : ActionButtonsWidget(info: info),
          ],
        ),
      ),
    );

    return SlideTransitionWidget(
      child: isLoading
          ? customShimmer(childWidget: child) // Apply shimmer if isLoading is true
          : child, // Otherwise, show the actual content
    );
  }
}
