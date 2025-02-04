import 'package:flutter/material.dart';
import 'package:flutter/painting.dart'; // Import for TextPainter
import 'package:social_media/core/Responsive/Models/device_info.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/features/posts/presentation/homePage/ui/widgets/show_report_post_dialog_widget.dart';

class PostCardWidget extends StatelessWidget {
  const PostCardWidget({
    super.key,
    required this.deviceInfo,
    required this.title,
    required this.content,
    required this.author,
    required this.timeAgo,
  });

  final DeviceInfo deviceInfo;
  final String title;
  final String content;
  final String author;
  final String timeAgo;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: deviceInfo.localWidth * 0.9,
        height: deviceInfo.localHeight * 0.28,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: deviceInfo.localWidth * 0.01,
              blurRadius: deviceInfo.localWidth * 0.02,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(deviceInfo.localWidth * 0.03),
        ),
        child: Padding(
          padding: EdgeInsets.all(deviceInfo.localWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: deviceInfo.localWidth * 0.68,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: TextStyles.inter18BoldBlack.copyWith(fontSize: deviceInfo.screenWidth * 0.05),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: ColorsManager.redColor.withOpacity(0.7),
                      size: deviceInfo.screenWidth * 0.08,
                    ),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                thickness: deviceInfo.screenWidth * 0.002,
                height: deviceInfo.localHeight * 0.015,
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/man_profile.png',
                    width: deviceInfo.localWidth * 0.1,
                    height: deviceInfo.localHeight * 0.1,
                  ),
                  SizedBox(width: deviceInfo.localWidth * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author,
                        style: TextStyles.inter18BoldBlack.copyWith(fontSize: deviceInfo.screenWidth * 0.04),
                      ),
                      Text(
                        timeAgo.substring(0, 10),
                        style: TextStyles.inter18Regularblack.copyWith(fontSize: deviceInfo.screenWidth * 0.03),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ShowReportPostDialogWidget(deviceInfo: deviceInfo);
                        },
                      );
                    },
                    child: Text(
                      'Report',
                      style: TextStyle(color: ColorsManager.redColor, fontSize: deviceInfo.screenWidth * 0.036),
                    ),
                  ),
                ],
              ),
              SizedBox(height: deviceInfo.localHeight * 0.001),
              // Content with fixed two lines
              Text(
                content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                softWrap: true,
                style: TextStyles.inter18Regular.copyWith(fontSize: deviceInfo.screenWidth * 0.04),
              ),
            ],
          ),
        ),
      ),
      onTap: () {},
    );
  }
}
