import 'package:flutter/material.dart';
import 'package:social_media/core/routing/routs.dart';

import '../../../../../core/Responsive/ui_component/info_widget.dart';
import '../../../../../core/theming/styles.dart';
import 'widgets/create_post_widget.dart';
import 'widgets/post_card_widget.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});
  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo) {
        return SafeArea(
          child: Scaffold(
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        deviceInfo.screenWidth * 0.05,
                        deviceInfo.screenHeight * 0.019,
                        deviceInfo.screenWidth * 0.035,
                        0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildHeader(deviceInfo),
                          SizedBox(height: deviceInfo.localHeight * 0.04),
                          Text(
                            'What’s on your head?',
                            style: TextStyles.inter18Bold.copyWith(
                              fontSize: deviceInfo.screenWidth * 0.06,
                            ),
                          ),
                          SizedBox(height: deviceInfo.localHeight * 0.02),
                          CreatePostWidget(deviceInfo: deviceInfo),
                          SizedBox(height: deviceInfo.localHeight * 0.02),
                          _buildFeedHeader(deviceInfo, context),
                          SizedBox(height: deviceInfo.localHeight * 0.02),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.fromLTRB(
                          deviceInfo.screenWidth * 0.05,
                          0,
                          deviceInfo.screenWidth * 0.05,
                          deviceInfo.localHeight * 0.02,
                        ),
                        child: PostCardWidget(deviceInfo: deviceInfo),
                      ),
                      childCount: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(deviceInfo) {
    return Row(
      children: [
        Image.asset(
          'assets/images/Title_img.png',
          width: deviceInfo.localWidth * 0.5,
          height: deviceInfo.localHeight * 0.04,
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.menu, size: deviceInfo.localWidth * 0.09),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildFeedHeader(deviceInfo, context) {
    return Row(
      children: [
        Text(
          'Feed',
          style: TextStyles.inter18Bold
              .copyWith(fontSize: deviceInfo.screenWidth * 0.06),
        ),
        const Spacer(),
        IconButton(
          icon: Image.asset(
            'assets/images/Filters_icon.png',
            width: deviceInfo.localWidth * 0.09,
            height: deviceInfo.localWidth * 0.09,
          ),
          onPressed: () => Navigator.pushNamed(context, Routes.filteringScreen),
        )
      ],
    );
  }
}
