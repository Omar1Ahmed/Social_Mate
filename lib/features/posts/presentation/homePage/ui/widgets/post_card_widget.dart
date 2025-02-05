import 'package:flutter/material.dart';
import 'package:social_media/features/posts/presentation/homePage/ui/widgets/show_report_post_dialog_widget.dart';

import '../../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';

class PostCardWidget extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final String title;
  final String content;
  final String author;
  final String timeAgo;

  const PostCardWidget({
    super.key,
    required this.deviceInfo,
    required this.title,
    required this.content,
    required this.author,
    required this.timeAgo,
  });

  @override
  _PostCardWidgetState createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _opacityAnimation;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: _offsetAnimation.value,
            child: child,
          ),
        );
      },
      child: InkWell(
        child: Container(
          width: widget.deviceInfo.localWidth * 0.9,
          height: widget.deviceInfo.localHeight * 0.28,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: widget.deviceInfo.localWidth * 0.01,
                blurRadius: widget.deviceInfo.localWidth * 0.02,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(widget.deviceInfo.localWidth * 0.03),
          ),
          child: Padding(
            padding: EdgeInsets.all(widget.deviceInfo.localWidth * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: widget.deviceInfo.localWidth * 0.68,
                      child: Text(
                        widget.title,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyles.inter18BoldBlack.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.05),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        color: ColorsManager.redColor.withOpacity(0.7),
                        size: widget.deviceInfo.screenWidth * 0.08,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  thickness: widget.deviceInfo.screenWidth * 0.002,
                  height: widget.deviceInfo.localHeight * 0.015,
                ),
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ShowReportPostDialogWidget(deviceInfo: widget.deviceInfo);
                          },
                        );
                      },
                      child: Text(
                        'Report',
                        style: TextStyle(color: ColorsManager.redColor, fontSize: widget.deviceInfo.screenWidth * 0.036),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: widget.deviceInfo.localHeight * 0.001),
                // Content with fixed two lines
                Text(
                  widget.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  softWrap: true,
                  style: TextStyles.inter18Regular.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.04),
                ),
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
