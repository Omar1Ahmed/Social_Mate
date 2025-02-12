import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/shared/widgets/animation/tween_animation_widget.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/features/admin/presentation/report_details/ui/widgets/related_report_widget.dart';
import 'package:social_media/features/admin/presentation/report_details/ui/widgets/report_detials_widget.dart';
import '../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../core/shared/widgets/animation/slide_Transition__widget.dart';
import '../../../../../core/shared/widgets/header_widget.dart';
import '../../../../../core/shared/widgets/postDetailsPostCard.dart';
import '../../../../../core/theming/styles.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, info) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: ColorsManager.whiteColor,
          body: CustomScrollView(
            slivers: [
              // Header Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(info.screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWidget(
                        info: info,
                        onBackPressed: () {
                          context.pop();
                        },
                        titleImageAsset: 'assets/images/Title_img.png',
                      ),
                      SizedBox(height: info.screenHeight * 0.02),
                      ReportDetialsWidget(
                        info: info,
                      ),
                      SizedBox(height: info.screenHeight * 0.02),
                      SlideTransitionWidget(
                        child: PostDetailsPostCard(
                          info: info,
                          showStars: false,
                          titleText: 'Post Details',
                          isTitleShimmer: false,
                          showDeleteButton: false,
                          isNameAndDateShimmer: false,
                          showReportButton: false,
                          isContentShimmer: false,
                          isCommentsCountShimmer: false,
                          isRateAverageShimmer: false,
                          fullNameText: 'Abdullah Ahmed',
                          formattedDateText: '2023-05-12 9:00 AM',
                          contentText: 'loram ipsum dolor sit amet consectetur adipiscing elit. ',
                          commentsCountText: 'Comments 19',
                          rateAverageText: 'Rate 5',
                          SelectedRatingValue: 5,
                          disableStars: true,
                        ),
                      ),
                      SizedBox(height: info.screenHeight * 0.02),
                    ],
                  ),
                ),
              ),

              // Related Reports Section
              _buildRelatedReports(info),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildRelatedReports(DeviceInfo deviceInfo) {
    const int relatedReportsCount = 10;

    return SliverToBoxAdapter(
      child: Center(
        // Use Center to horizontally center the container
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: deviceInfo.screenWidth * 0.9, // Restrict the width to 90% of the screen
          ),
          child: Container(
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
            child: Padding(
              padding: EdgeInsets.all(deviceInfo.screenWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Related Reports',
                    style: TextStyles.inter18BoldBlack.copyWith(fontSize: deviceInfo.screenWidth * 0.045),
                  ),
                  Divider(
                    thickness: 2,
                    height: deviceInfo.screenHeight * 0.02,
                    color: ColorsManager.blackColor.withOpacity(0.6),
                  ),
                  SizedBox(height: deviceInfo.screenHeight * 0.02),
                  TweenAnimationWidget(
                    deviceInfo: deviceInfo,
                    index: 0,
                    child: _buildScrollableRelatedReportsList(deviceInfo, relatedReportsCount),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScrollableRelatedReportsList(DeviceInfo deviceInfo, int count) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), // Prevents scrolling inside the list
      itemCount: count,
      itemBuilder: (context, index) {
        return Column(
          children: [
            RelatedReportWidget(
              deviceInfo: deviceInfo,
              fullName: 'User ${index + 1}',
              createdAt: '2023-05-12 9:00 AM',
              state: 'pending',
            ),
            if (index != count - 1) SizedBox(height: deviceInfo.screenHeight * 0.02),
          ],
        );
      },
    );
  }
}
