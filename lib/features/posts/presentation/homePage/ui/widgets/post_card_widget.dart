
import 'package:flutter/material.dart';
import 'package:social_media/core/di/di.dart';

import '../../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../../core/entities/post_entity.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../../logic/cubit/home_cubit_cubit.dart';

class PostCardWidget extends StatefulWidget {
  final DeviceInfo deviceInfo;
  final PostEntity post;
  final bool isIdMatch;
  const PostCardWidget({
    super.key,
    required this.deviceInfo,
    required this.isIdMatch,
    required this.post,
  });

  @override
  // ignore: library_private_types_in_public_api
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
          height: widget.deviceInfo.localHeight * 0.21,
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
                        widget.post.title,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyles.inter18BoldBlack.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.05),
                      ),
                    ),
                    const Spacer(),
                    widget.isIdMatch
                        ? const SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              final postId = widget.post.id;
                              if (postId == 0) {
                                print('Invalid post ID: $postId');
                                return;
                              }
                              print('Deleting post with ID: $postId');
                              getIt.get<HomeCubit>().deletePost(postId);
                            },
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
                    Text(
                      widget.post.createdBy.fullName,
                      style: TextStyles.inter18BoldBlack.copyWith(fontSize: widget.deviceInfo.screenWidth * 0.04),
                    ),
                    const Spacer(),
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
              ],
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
