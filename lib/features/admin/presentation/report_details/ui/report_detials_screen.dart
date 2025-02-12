import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/features/admin/presentation/report_details/ui/widgets/report_detials_widget.dart';

import '../../../../../core/shared/widgets/postDetailsPostCard.dart';

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
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(info.screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(info, context),
                      SizedBox(height: info.screenHeight * 0.02),
                      ReportDetialsWidget(
                        info: info,
                      ),
                      SizedBox(height: info.screenHeight * 0.02),
                      PostDetailsPostCard(
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
                        contentText: 'Content',
                        commentsCountText: 'Comments 19',
                        rateAverageText: 'Rate 5',
                        SelectedRatingValue: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader(DeviceInfo info, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: info.screenWidth * 0.02,
        vertical: info.screenHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/Title_img.png',
            width: info.screenWidth * 0.48,
            height: info.screenHeight * 0.06,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: info.screenWidth * 0.02,
          ),
          IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: info.screenWidth * 0.08,
              color: ColorsManager.primaryColor,
            ),
            onPressed: () => context.pop(),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.all(info.screenWidth * 0.02),
              backgroundColor: ColorsManager.lightGreyColor,
              shadowColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
