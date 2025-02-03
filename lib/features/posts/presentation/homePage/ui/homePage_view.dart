import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/routing/routs.dart';
import '../../../../../core/Responsive/ui_component/info_widget.dart';
import '../../../../../core/theming/styles.dart';
import '../logic/cubit/home_cubit_cubit.dart';
import 'widgets/create_post_widget.dart';
import 'widgets/post_card_widget.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getPosts();

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
                          _buildHeader(deviceInfo, context),
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
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is PostLoaded) {
                        final posts = state.posts;
                        final totalPosts = state.totalPosts;
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => Padding(
                              padding: EdgeInsets.fromLTRB(
                                deviceInfo.screenWidth * 0.05,
                                0,
                                deviceInfo.screenWidth * 0.05,
                                deviceInfo.localHeight * 0.02,
                              ),
                              child: PostCardWidget(deviceInfo: deviceInfo, title: posts[index].title, content: posts[index].content, author: posts[index].createdBy.fullName, timeAgo: posts[index].createdOn.toString()),
                            ),
                            childCount: totalPosts,
                          ),
                        );
                      } else if (state is PostLoading) {
                        return SliverFillRemaining(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return SliverFillRemaining(
                          child: Center(
                            child: Text('no data found'),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(deviceInfo,BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/Title_img.png',
          width: deviceInfo.localWidth * 0.5,
          height: deviceInfo.localHeight * 0.04,
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.search, size: deviceInfo.localWidth * 0.09),
          onPressed: () {
            context.pushNamed(Routes.filteringScreen);
          },
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
        // IconButton(
        //   icon: Image.asset(
        //     'assets/images/Filters_icon.png',
        //     width: deviceInfo.localWidth * 0.09,
        //     height: deviceInfo.localWidth * 0.09,
        //   ),
        //   onPressed: () => ,
        // )
      ],
    );
  }
}
