import 'package:flutter/material.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/shared/show_report_post_dialog_widget.dart';
import 'package:social_media/features/posts/presentation/postDetails/presentation/logic/post_details_cubit.dart';
import '../../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../../core/entities/post_entity.dart';
import '../../../../../../core/routing/routs.dart';
import '../../../../../../core/shared/show_delete_dialog_widget.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../../logic/cubit/home_cubit_cubit.dart';

class PostCardWidget extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final PostEntity post;
  final bool idNotMatch;

  const PostCardWidget({
    super.key,
    required this.deviceInfo,
    required this.idNotMatch,
    required this.post,
  });

  @override
  // ignore: library_private_types_in_public_api
  _PostCardWidgetState createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _animationController,
        child: InkWell(
          onTap: () {
            PostDetailsCubit().setSelectedPost(widget.post.id);
            context.pushNamed(
              Routes.postDetailsScreen,
            );
          },
          child: Container(
            width: widget.deviceInfo.screenWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: widget.deviceInfo.screenWidth * 0.01,
                  blurRadius: widget.deviceInfo.screenWidth * 0.02,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(widget.deviceInfo.screenWidth * 0.03),
            ),
            child: Padding(
              padding: EdgeInsets.all(widget.deviceInfo.screenWidth * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.post.title,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyles.inter18BoldBlack.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.05),
                        ),
                      ),
                      widget.idNotMatch
                          ? const SizedBox.shrink()
                          : IconButton(
                              onPressed: () {
                                final postId = widget.post.id;
                                if (postId == 0) {
                                  return;
                                }
                                showDialog(
                                    context: context,
                                    builder: (context) => ShowDeleteDialogWidget(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          getIt.get<HomeCubit>().deletePost(postId);
                                          context.pushReplacementNamed(Routes.homePage);
                                        },
                                        deviceInfo: widget.deviceInfo));

                                getIt.get<HomeCubit>().onRefresh();
                              },
                              icon: Icon(
                                Icons.close,
                                color: ColorsManager.redColor.withOpacity(0.7),
                                size: widget.deviceInfo.screenWidth * 0.08,
                              ),
                            ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: widget.deviceInfo.screenWidth * 0.002,
                    height: widget.deviceInfo.screenHeight * 0.015,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.post.createdBy.fullName,
                          style: TextStyles.inter18BoldBlack.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.04),
                        ),
                      ),
                      Text(
                        widget.post.createdOn.toString().substring(0, 16),
                        style: TextStyles.inter18Regularblack.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.03),
                      ),
                    ],
                  ),
                  SizedBox(height: widget.deviceInfo.localHeight * 0.01),
                  Text(
                    widget.post.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    softWrap: true,
                    style: TextStyles.inter18RegularWithOpacity.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.04),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          // Handle report action
                          // getIt.get<HomeCubit>().reportPost(widget.post.id);
                          showDialog(
                            context: context,
                            builder: (context) => ShowReportPostDialogWidget(
                              deviceInfo: widget.deviceInfo,
                              onPressedReport: () {
                                // getIt.get<HomeCubit>().reportPost(widget.post.id);
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Report",
                          style: TextStyles.inter18Regularblack.copyWith(color: ColorsManager.redColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
