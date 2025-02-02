import 'package:flutter/material.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/routing/routs.dart';
import '../../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';

class PostCardWidget extends StatefulWidget {
  const PostCardWidget({super.key, required this.deviceInfo, required this.title, required this.content, required this.author, required this.timeAgo});
  final DeviceInfo deviceInfo;
  final String title;
  final String content;
  final String author;
  final String timeAgo;

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  bool _isExpanded = true; 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: widget.deviceInfo.localWidth * 0.9,
        height: _isExpanded ? widget.deviceInfo.localHeight * 0.31 : widget.deviceInfo.localHeight * 0.37,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(widget.deviceInfo.localWidth * 0.03),
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.deviceInfo.localWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyles.inter18Bold.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.06),
              ),
              Divider(color: Colors.black, thickness: 1.5),
              Row(
                children: [
                  Image.asset(
                    'assets/images/man_profile.png',
                    width: widget.deviceInfo.localWidth * 0.1,
                    height: widget.deviceInfo.localHeight * 0.1,
                  ),
                  SizedBox(width: widget.deviceInfo.localWidth * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.author,
                        style: TextStyles.inter18BoldBlack.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.04),
                      ),
                      Text(
                        widget.timeAgo.substring(0, 10),
                        style: TextStyles.inter18Regularblack.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.03),
                      ),
                    ],
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Report',
                      style: TextStyle(color: ColorsManager.redColor, fontSize: widget.deviceInfo.screenWidth * 0.036),
                    ),
                  ),
                ],
              ),
              SizedBox(height: widget.deviceInfo.localHeight * 0.01),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.content,
                      maxLines: _isExpanded ? null : 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyles.inter18Regular.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.04),
                    ),
                    if (_isExpanded)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isExpanded = false;
                          });
                        },
                        child: Text(
                          'See More',
                          style: TextStyle(
                            color: ColorsManager.primaryColor,
                            fontSize: widget.deviceInfo.screenWidth * 0.04,
                          ),
                        ),
                      )
                    else
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isExpanded = true;
                          });
                        },
                        child: Text(
                          'Show Less',
                          style: TextStyle(
                            color: ColorsManager.primaryColor,
                            fontSize: widget.deviceInfo.screenWidth * 0.04,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        context.pushNamed(Routes.postDetailsScreen);
      },
    );
  }
}
