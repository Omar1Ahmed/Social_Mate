import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/features/posts/presentation/homePage/ui/widgets/log_out_dialog.dart';
import '../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../core/Responsive/ui_component/info_widget.dart';
import '../../../../../core/routing/routs.dart';
import '../../../../../core/shared/widgets/animation/tween_animation_widget.dart';
import '../logic/cubit/home_cubit_cubit.dart';
import 'widgets/build_error_widget.dart';
import 'widgets/create_post_widget.dart';
import '../../../../../core/shared/widgets/post_card_widget.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView> with TickerProviderStateMixin {
  late final AnimationController _createPostAnimationController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _createPostAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
    _scrollController = ScrollController()..addListener(_onScroll);
    // Fetch posts initially
    context.read<HomeCubit>().getPosts();
  }

  @override
  void dispose() {
    _createPostAnimationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final homeCubit = context.read<HomeCubit>();
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100 && !homeCubit.isLoadingMore && homeCubit.hasMorePosts) {
      homeCubit.loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Transparent to show SafeArea effect
      statusBarIconBrightness: Brightness.dark, // Use Brightness.light for white icons

    ));
    return InfoWidget(
      builder: (context, deviceInfo) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocListener<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is PostDeleted || state is PostCreated) {
                  context.pop();
                  context.read<HomeCubit>().onRefresh();
                } else if (state is PostError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  return RefreshIndicator(
                    color: ColorsManager.primaryColor,
                    onRefresh: () => context.read<HomeCubit>().onRefresh(),
                    child: GestureDetector(
                      onTap: () => FocusScope.of(context).unfocus(),
                      child: CustomScrollView(
                        controller: _scrollController,
                        slivers: [
                          _buildHeaderSection(deviceInfo),
                          _buildPostList(deviceInfo, state),
                          _buildLoadingIndicator(deviceInfo, state),
                          SliverToBoxAdapter(
                            child: SizedBox(height: deviceInfo.localHeight * 0.1),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: SizedBox(
              width: deviceInfo.screenWidth * 0.15,
              height: deviceInfo.screenWidth * 0.15,
              child: FloatingActionButton(
                heroTag: 'adminReportButton',
                backgroundColor: Colors.white,
                foregroundColor: ColorsManager.primaryColor,
                onPressed: () => context.pushNamed(Routes.adminReportScreen),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(deviceInfo.screenWidth * 0.08),
                ),
                elevation: deviceInfo.screenWidth * 0.02,
                mini: deviceInfo.screenWidth < 400,
                materialTapTargetSize: MaterialTapTargetSize.padded,
                child: Icon(
                  Icons.edit_outlined,
                  color: ColorsManager.primaryColor,
                  size: deviceInfo.screenWidth * 0.06,
                ),
              ),
            ),
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection(DeviceInfo deviceInfo) {
    return SliverToBoxAdapter(
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
            Divider(
              height: deviceInfo.localHeight * 0.02,
              thickness: deviceInfo.screenWidth * 0.001,
              color: ColorsManager.greyColor,
            ),
            SizedBox(height: deviceInfo.localHeight * 0.02),
            _buildAnimatedCreatePostWidget(deviceInfo),
            SizedBox(height: deviceInfo.localHeight * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedCreatePostWidget(DeviceInfo deviceInfo) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _createPostAnimationController,
          curve: Curves.easeInOut,
        ),
      ),
      child: CreatePostWidget(deviceInfo: deviceInfo),
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
            width: deviceInfo.screenWidth * 0.48,
            height: deviceInfo.screenHeight * 0.06,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: deviceInfo.screenWidth * 0.02,
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              size: deviceInfo.screenWidth * 0.08,
              color: ColorsManager.primaryColor,
            ),
            onPressed: () => context.pushNamed(Routes.filteringScreen),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.all(deviceInfo.screenWidth * 0.02),
              backgroundColor: ColorsManager.lightGreyColor,
              shadowColor: Colors.transparent,
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0)),
          ),
          IconButton(
            onPressed: () {
              logOutDialog(context, deviceInfo);
            },
            icon: Icon(
              Icons.logout_outlined,
              color: ColorsManager.primaryColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPostList(DeviceInfo deviceInfo, HomeState state) {
    if (state is PostLoaded || state is PostLoadingMore) {
      final posts = state is PostLoaded ? state.posts : (state as PostLoadingMore).posts;
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index >= posts.length) return const SizedBox.shrink();
            final isNotMatch = posts[index].createdBy.id == getIt<userMainDetailsCubit>().state.userId ? false : true;
            return TweenAnimationWidget(
              index: index,
              deviceInfo: deviceInfo,
              child: PostCardWidget(
                post: posts[index],
                deviceInfo: deviceInfo,
                idNotMatch: isNotMatch,
                onPressedDelete: () {
                  context.pop();
                  final postId = posts[index].id;
                  getIt.get<HomeCubit>().deletePost(postId);
                  context.pushReplacementNamed(Routes.homePage);
                },
              ),
            );
          },
          childCount: posts.length,
        ),
      );
    }
    return SliverFillRemaining(
      child: state is PostError ? BuildErrorWidget(deviceInfo: deviceInfo) : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildLoadingIndicator(DeviceInfo deviceInfo, HomeState state) {
    if (state is PostLoadingMore) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(deviceInfo.screenWidth * 0.05),
          child: Center(
            child: CircularProgressIndicator(color: ColorsManager.primaryColor),
          ),
        ),
      );
    }
    return const SliverToBoxAdapter(child: SizedBox.shrink());
  }

  // void _showCreatePostDialog(DeviceInfo deviceInfo) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => ShowCreatePostDialogWidget(
  //       deviceInfo: deviceInfo,
  //     ),
  //   );
  // }
}
