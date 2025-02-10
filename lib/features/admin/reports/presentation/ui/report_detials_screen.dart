import 'package:flutter/material.dart';
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/core/shared/widgets/CommentCard.dart';
import 'package:social_media/core/shared/widgets/post_card_widget.dart';

import '../../../../../core/entities/post_entity.dart';
import '../../../../../core/routing/routs.dart';
import '../../../../../core/shared/widgets/animation/tween_animation_widget.dart';
import '../../../../posts/data/model/entities/commentEntity.dart';

class ReportDetailsScreen extends StatelessWidget {
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
                      _buildActionButtons(info),
                      SizedBox(height: info.screenHeight * 0.02),
                      _buildPostDetails(info),
                      SizedBox(height: info.screenHeight * 0.02),
                      _buildReportReason(info),
                      SizedBox(height: info.screenHeight * 0.02),
                      _buildCommentsSection(info),
                      SizedBox(height: info.screenHeight * 0.04),
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

  Widget _buildPostDetails(DeviceInfo info) {
    return PostCardWidget(
      deviceInfo: info,
      idNotMatch: true,
      post: PostEntity(id: 2, title: 'Sample title', content: 'Sample content', createdBy: UserEntity(id: 3, fullName: 'Sample name'), createdOn: DateTime.now(), FormattedDate: 'Sample date'),
      onPressedDelete: () {},
    );
  }

  Widget _buildReportReason(DeviceInfo info) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Report Reason:', style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.045)),
          SizedBox(height: info.screenHeight * 0.01),
          Text('Sample reason for report.', style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: info.screenWidth * 0.04)),
        ],
      ),
    );
  }

  Widget _buildCommentsSection(DeviceInfo info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('3 Comments', style: TextStyles.inter18BoldBlack.copyWith(fontSize: info.screenWidth * 0.05)),
        SizedBox(height: info.screenHeight * 0.01),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return TweenAnimationWidget(
              index: index,
              deviceInfo: info,
              child: CommentCard(
                comment: CommentEntity(
                  id: index,
                  content: 'Sample comment $index',
                  FormattedDate: 'Sample date',
                  createdBy: UserEntity(fullName: 'Sample name', id: index),
                  numOfDisLikes: 0,
                  numOfLikes: 0,
                  createdOn: DateTime.now(),
                ),
                info: info,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionButtons(DeviceInfo info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: Size(info.screenWidth * 0.4, info.screenHeight * 0.06)),
          child: Text('Accept', style: TextStyle(fontSize: info.screenWidth * 0.04, color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red, minimumSize: Size(info.screenWidth * 0.4, info.screenHeight * 0.06)),
          child: Text('Reject', style: TextStyle(fontSize: info.screenWidth * 0.04, color: Colors.white)),
        ),
      ],
    );
  }
}
