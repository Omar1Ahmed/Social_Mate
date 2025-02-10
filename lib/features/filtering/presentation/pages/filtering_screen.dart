import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/theming/colors.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/core/userMainDetails/userMainDetails_cubit.dart';
import 'package:social_media/features/filtering/domain/entities/filtering_post_entity.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtered_users/filtered_users_cubit.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtering_cubit.dart';
import 'package:social_media/features/filtering/presentation/cubit/sharing_data/sharing_data_cubit.dart';
import 'package:social_media/features/filtering/presentation/widgets/filtered_post_card.dart';
import 'package:social_media/features/filtering/presentation/widgets/filtering_tile.dart';
import 'package:social_media/features/posts/presentation/homePage/logic/cubit/home_cubit_cubit.dart';

class FilteringScreen extends StatefulWidget {
  const FilteringScreen({super.key});

  @override
  State<FilteringScreen> createState() => _FilteringScreenState();
}

class _FilteringScreenState extends State<FilteringScreen> {
  Map<String, dynamic> queryParameters = {};
  List<FilteringPostEntity> posts = [];
  final ScrollController scrollController = ScrollController();
  //double scrollPosition = 0;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final token = context.read<userMainDetailsCubit>().state.token;
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      //scrollPosition = scrollController.position.pixels;
      final queryParams = context.read<SharingDataCubit>().state.queryParams;
      print('new queryParams: $queryParams');
      context
          .read<FilteringCubit>()
          .loadMoreFilteredPosts(queryParameters: queryParams, token: token!);
    }
    print('queryParameters after pagination : $queryParameters');
  }

  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Filtering',
            style: TextStyles.inter18BoldBlack,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: BlocListener<SharingDataCubit, SharingDataState>(
              listener: (context, sharingState) {
                if (sharingState.posts.isEmpty) {
                  posts.clear();
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilteringTile(
                    filteringCubit: context.read<FilteringCubit>(),
                    sharingDataCubit: context.read<SharingDataCubit>(),
                    filteredUsersCubit: context.read<FilteredUsersCubit>(),
                  ),
                  SizedBox(height: 16),
                  BlocBuilder<FilteringCubit, FilteringState>(
                    builder: (context, state) {
                      if (state is FilteredPostsIsLoading) {
                        return Center(
                            child: LinearProgressIndicator(
                          color: ColorsManager.primaryColor,
                        ));
                      } else if (state is FilteredPostsIsLoaded) {
                        if (state.filteredPosts.isNotEmpty) {
                          final newPosts = state.filteredPosts.where((newPost) {
                            return !posts.any((existingPost) =>
                                existingPost.id == newPost.id);
                          }).toList();
                          posts.addAll(newPosts);
                        }
                        if (posts.isEmpty) {
                          print('retrived data is empty ya 3m'); // Debug
                        }
                        print(
                            'this is the filtered ${posts.length.toString()}');
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                'Posts Filtered : ${state.filteredPosts[0].total.toString()}',
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: posts.length + (state.hasMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                print('Filtering State: $state');
                                if (index == posts.length && state.hasMore) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                return Column(
                                  children: [
                                    FilteredPostCard(
                                      filteringCubit:
                                          context.read<FilteringCubit>(),
                                      homeCubit: context.read<HomeCubit>(),
                                      postId: posts[index].id,
                                      postOwnerId: posts[index].userId,
                                      title: posts[index].title,
                                      postOwner: posts[index].createdBy,
                                      date: posts[index].createdOn.toString(),
                                      content: posts[index].content,
                                      onPostDeleted: (deletedPostId) {
                                        setState(() {
                                          posts.removeWhere((post) =>
                                              post.id == deletedPostId);
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 16,
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        );
                      } else if (state is FilteredPostsHasError) {
                        return Text('Sorry something went wrong , Try again');
                      } else if (state is FilteredPostsIsEmpty) {
                        return Center(
                          child: Text('No posts found'),
                        );
                      } else {
                        return Center(
                          child: Text('No posts yet , try to filter some'),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
