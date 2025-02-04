import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/routing/routs.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/token/token_cubit.dart';
import '../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../core/Responsive/ui_component/info_widget.dart';
import '../../../../../core/theming/styles.dart';
import '../logic/cubit/home_cubit_cubit.dart';
import 'widgets/create_post_widget.dart';
import 'widgets/post_card_widget.dart';
import 'widgets/show_create_post_dialog_widget.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HomeCubit>().getPosts();

    print('Print token in Home Page: ${context.read<TokenCubit>().state.token}');
    return InfoWidget(
      builder: (context, deviceInfo) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
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
                          SizedBox(height: deviceInfo.localHeight * 0.02),
                          CreatePostWidget(deviceInfo: deviceInfo),
                          SizedBox(height: deviceInfo.localHeight * 0.02),
                          Divider(
                            height: deviceInfo.localHeight * 0.02,
                            thickness: deviceInfo.screenWidth * 0.001,
                            color: ColorsManager.greyColor,),
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
                              child: PostCardWidget(
                                deviceInfo: deviceInfo,
                                title: posts[index].title,
                                content: posts[index].content,
                                author: posts[index].createdBy.fullName,
                                timeAgo: posts[index].createdOn.toString(),
                              ),
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
                      } else if (state is PostError) {
                        return SliverFillRemaining(
                          child: Center(
                            child: Text('no data found'),
                          ),
                        );
                      }
                      return SliverFillRemaining(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: deviceInfo.localHeight * 0.1),
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: ColorsManager.primaryColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ShowCreatePostDialogWidget(deviceInfo: deviceInfo);
                  },
                );
              },
              child: Icon(
                Icons.edit_outlined,
                color: ColorsManager.primaryColor,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(DeviceInfo deviceInfo, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceInfo.localWidth * 0.02,
        vertical: deviceInfo.localHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/images/Title_img.png',
            width: deviceInfo.localWidth * 0.48,
            height: deviceInfo.localHeight * 0.06,
            fit: BoxFit.contain,
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.search,
              size: deviceInfo.localWidth * 0.08,
              color: ColorsManager.primaryColor,
            ),
            onPressed: () {
              context.pushNamed(Routes.filteringScreen);
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.all(deviceInfo.localWidth * 0.02),
              backgroundColor: ColorsManager.lightGreyColor,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              shadowColor: Colors.transparent,
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0)),
          ),
          SizedBox(width: deviceInfo.localWidth * 0.02),
        ],
      ),
    );
  }

  Widget _buildFeedHeader(DeviceInfo deviceInfo, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceInfo.localWidth * 0.04,
        vertical: deviceInfo.localHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Feed',
            style: TextStyles.inter18Regular.copyWith(fontSize: deviceInfo.localWidth * 0.06),
          ),
          IconButton(
            icon: Icon(
              Icons.home,
              size: deviceInfo.localWidth * 0.08,
              color: ColorsManager.primaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.person,
              size: deviceInfo.localWidth * 0.08,
              color: ColorsManager.primaryColor,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              size: deviceInfo.localWidth * 0.08,
              color: ColorsManager.primaryColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
