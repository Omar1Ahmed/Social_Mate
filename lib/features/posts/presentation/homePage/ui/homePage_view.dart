import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/di/di.dart';
import 'package:social_media/core/helper/SharedPref/SharedPrefKeys.dart';
import 'package:social_media/core/helper/SharedPref/sharedPrefHelper.dart';
import 'package:social_media/core/helper/extantions.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/userMainDetails/jwt_token_decode/data/repository/jwt_token_decode_repository_imp.dart';
import 'package:social_media/features/posts/presentation/homePage/ui/widgets/log_out_dialog.dart';
import '../../../../../core/Responsive/Models/device_info.dart';
import '../../../../../core/Responsive/ui_component/info_widget.dart';
import '../../../../../core/routing/routs.dart';
import '../logic/cubit/home_cubit_cubit.dart';
import 'widgets/build_error_widget.dart';
import 'widgets/create_post_widget.dart';
import 'widgets/post_card_widget.dart';
import 'widgets/show_create_post_dialog_widget.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView>
    with TickerProviderStateMixin {
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
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !homeCubit.isLoadingMore &&
        homeCubit.hasMorePosts) {
      homeCubit.loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      builder: (context, deviceInfo) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: BlocListener<HomeCubit, HomeState>(
              listener: (context, state) {
                if (state is PostDeleted) {
                  // Optionally refresh the page after deletion
                  context.read<HomeCubit>().onRefresh();
                } else if (state is PostError) {
                  // Show an error message or snack bar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              child: RefreshIndicator(
                color: ColorsManager.primaryColor,
                onRefresh: () async =>
                    await context.read<HomeCubit>().onRefresh(),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      _buildHeaderSection(deviceInfo),
                      _buildPostList(deviceInfo),
                      _buildLoadingIndicator(deviceInfo),
                      SliverToBoxAdapter(
                          child:
                              SizedBox(height: deviceInfo.localHeight * 0.1)),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              foregroundColor: ColorsManager.primaryColor,
              onPressed: () => _showCreatePostDialog(deviceInfo),
              child:
                  Icon(Icons.edit_outlined, color: ColorsManager.primaryColor),
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
            width: deviceInfo.localWidth * 0.48,
            height: deviceInfo.localHeight * 0.06,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: 16,
          ),
          IconButton(
            icon: Icon(
              Icons.search,
              size: deviceInfo.localWidth * 0.08,
              color: ColorsManager.primaryColor,
            ),
            onPressed: () => context.pushNamed(Routes.filteringScreen),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.all(deviceInfo.localWidth * 0.02),
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

  Widget _buildPostList(DeviceInfo deviceInfo) {
    // by marwan
    final JwtTokenDecodeRepositoryImp decodedToken =
        getIt.get<JwtTokenDecodeRepositoryImp>();
    final decodedTokenFromCache = decodedToken.decodeToken(
        getIt.get<SharedPrefHelper>().getString(SharedPrefKeys.saveKey)!);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is PostLoading) {
          return SliverFillRemaining(
            child: Center(
                child: CircularProgressIndicator(
                    color: ColorsManager.primaryColor)),
          );
        } else if (state is PostLoaded || state is PostLoadingMore) {
          final posts = state is PostLoaded
              ? state.posts
              : (state as PostLoadingMore).posts;
          if (posts.isEmpty) {
            return SliverFillRemaining(
              child: Center(child: Text("No posts available")),
            );
          }
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= posts.length) {
                  return const SizedBox.shrink();
                }
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceInfo.screenWidth * 0.05,
                    vertical: deviceInfo.localHeight * 0.01,
                  ),
                  child: PostCardWidget(
                    key: ValueKey(posts[index].id),
                    deviceInfo: deviceInfo,
                    // modifications by marwan
                    idNotMatch: posts[index].createdBy.id ==
                            decodedTokenFromCache.userId
                        ? false
                        : true,
                    post: posts[index],
                  ),
                );
              },
              childCount: posts.length,
            ),
          );
        } else if (state is PostError) {
          return SliverFillRemaining(
            child: BuildErrorWidget(deviceInfo: deviceInfo),
          );
        } else if (state is PostDeletedLoading) {
          return SliverFillRemaining(
            child: Center(
                child: CircularProgressIndicator(
                    color: ColorsManager.primaryColor)),
          );
        } else {
          return SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildLoadingIndicator(DeviceInfo deviceInfo) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is PostLoadingMore) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: CircularProgressIndicator(
                    color: ColorsManager.primaryColor),
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }

  void _showCreatePostDialog(DeviceInfo deviceInfo) {
    showDialog(
      context: context,
      builder: (context) => ShowCreatePostDialogWidget(
        deviceInfo: deviceInfo,
      ),
    );
  }
}
