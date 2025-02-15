import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/shared/widgets/animation/slide_Transition__widget.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/features/admin/presentation/all_reports/ui/widgets/tags_widget.dart';

import '../../../../../../core/routing/routs.dart';
import '../../../report_details/logic/report_details_cubit.dart';

class MainReportCard extends StatelessWidget {
  final DeviceInfo deviceInfo;
  final String postTitle;
  final String reportedBy;
  final int postId;
  final int reportId;
  final String reportDate;
  final String reportCategory;
  final String reportStatus;
  const MainReportCard({
    super.key,
    required this.deviceInfo,
    required this.postTitle,
    required this.reportedBy,
    required this.postId,
    required this.reportDate,
    required this.reportCategory,
    required this.reportStatus,
    required this.reportId,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransitionWidget(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: deviceInfo.screenHeight * 0.01,
        ),
        child: InkWell(
          onTap: () {
            // todo navigate to report details with report id
            ReportDetailsCubit.setSelectedReport(5); // report id
            context.pushNamed(Routes.adminReportScreen);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: deviceInfo.screenWidth * 0.04, vertical: deviceInfo.screenHeight * 0.01),
            clipBehavior: Clip.antiAlias,
            width: deviceInfo.screenWidth * 0.9,
            height: deviceInfo.screenHeight * 0.2,
            decoration: BoxDecoration(
              color: ColorsManager.whiteColor,
              borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.04),
              border: Border.all(color: ColorsManager.primaryColor, width: deviceInfo.screenWidth * 0.003),
              boxShadow: <BoxShadow>[
                BoxShadow(color: ColorsManager.greyColor, spreadRadius: 1, blurRadius: 5, offset: Offset(0, 3))
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: deviceInfo.screenWidth * 0.78,
                      child: Text(
                        postTitle,
                        style: TextStyles.inter18Bold.copyWith(fontSize: deviceInfo.screenWidth * 0.05),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Reported by: $reportedBy',
                      style: TextStyles.inter14Regular.copyWith(color: Colors.black),
                    ),
                    Text(reportDate, style: TextStyles.inter14Regular.copyWith(color: ColorsManager.greyColor)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TagsWidget(
                      textColor: Colors.black,
                      deviceInfo: deviceInfo,
                      tagName: reportCategory,
                      tileColor: ColorsManager.whiteColor,
                    ),
                    TagsWidget(
                      deviceInfo: deviceInfo,
                      tagName: reportStatus,
                      tileColor: ColorsManager.orangeColor,
                      textColor: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
