import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/routing/routs.dart';
import '../../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../../core/theming/colors.dart';
import '../../../../../../core/theming/styles.dart';
import '../../logic/cubit/post_card_cubit.dart';

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
    return BlocProvider(
      create: (_) => PostCardCubit(),
      child: BlocBuilder<PostCardCubit, bool>(
        builder: (context, isExpanded) {
          return InkWell(
            child: Container(
              width: deviceInfo.localWidth * 0.9,
              height: isExpanded ? deviceInfo.localHeight * 0.31 : deviceInfo.localHeight * 0.37,
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
                      title,
                      style: TextStyles.inter18Bold.copyWith(fontSize: deviceInfo.screenWidth * 0.06),
                    ),
                    Divider(color: Colors.black, thickness: 1.5),
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
                          onPressed: () {},
                          child: Text(
                            'Report',
                            style: TextStyle(color: ColorsManager.redColor, fontSize: deviceInfo.screenWidth * 0.036),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: deviceInfo.localHeight * 0.01),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            content,
                            maxLines: isExpanded ? null : 3,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            style: TextStyles.inter18Regular.copyWith(fontSize: deviceInfo.screenWidth * 0.04),
                          ),
                          if (isExpanded)
                            TextButton(
                              onPressed: () {
                                context.read<PostCardCubit>().toggleExpansion();
                              },
                              child: Text(
                                'See More',
                                style: TextStyle(
                                  color: ColorsManager.primaryColor,
                                  fontSize: deviceInfo.screenWidth * 0.04,
                                ),
                              ),
                            )
                          else
                            TextButton(
                              onPressed: () {
                                context.read<PostCardCubit>().toggleExpansion();
                              },
                              child: Text(
                                'Show Less',
                                style: TextStyle(
                                  color: ColorsManager.primaryColor,
                                  fontSize: deviceInfo.screenWidth * 0.04,
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
        },
      ),
    );
  }
}
