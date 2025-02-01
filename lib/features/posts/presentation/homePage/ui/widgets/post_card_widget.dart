import 'package:flutter/material.dart';

import '../../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';
import 'posts_Button_widget.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({super.key, required this.deviceInfo});
  final DeviceInfo deviceInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceInfo.localWidth * 0.9,
      height: deviceInfo.localHeight * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
      ),
      child: Padding(
        padding: EdgeInsets.all(deviceInfo.localWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Post Title',
              style: TextStyles.inter18Bold.copyWith(fontSize: deviceInfo.screenWidth * 0.06),
            ),
            Divider(color: Colors.black, thickness: 2),
            Row(
              children: [
                Text(
                  'Post Author',
                  style: TextStyles.inter18BoldBlack.copyWith(fontSize: deviceInfo.screenWidth * 0.04),
                ),
                const Spacer(),
                Text(
                  'Post Date',
                  style: TextStyles.inter18BoldBlack.copyWith(fontSize: deviceInfo.screenWidth * 0.04),
                ),
              ],
            ),
            SizedBox(height: deviceInfo.localHeight * 0.02),
            Text(
              'Loram ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyles.inter18Regular.copyWith(fontSize: deviceInfo.screenWidth * 0.04),
            ),
            const Spacer(),
            Row(
              children: [
                PostsButtonWidget(
                  buttonColor: ColorsManager.primaryColor,
                  text: 'Show More',
                  deviceInfo: deviceInfo,
                  onPressed: () {},
                ),
                const Spacer(),
                PostsButtonWidget(
                  buttonColor: ColorsManager.redColor,
                  text: 'Report',
                  deviceInfo: deviceInfo,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
