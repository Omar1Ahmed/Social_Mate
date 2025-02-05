import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/features/filtering/could_be_shared/fake_end_points/real_end_points.dart';
import 'package:social_media/features/filtering/domain/entities/post_entity.dart';

import 'package:social_media/features/filtering/presentation/cubit/filtering_cubit.dart';
import 'package:social_media/features/filtering/presentation/widgets/filtered_post_card.dart';
import 'package:social_media/features/filtering/presentation/widgets/filtering_tile.dart';


class FilteringScreen extends StatefulWidget {
  const FilteringScreen({super.key});

  @override
  State<FilteringScreen> createState() => _FilteringScreenState();
}

class _FilteringScreenState extends State<FilteringScreen> {
  List<FilteringPostEntity> posts = [];
  final ScrollController scrollController = ScrollController();
  double scrollPosition = 0;
  @override
  void initState() {
    super.initState();
    // _cubit.getFilteredPosts(token: 'your-token');
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      scrollPosition = scrollController.position.pixels;
      context
          .read<FilteringCubit>()
          .loadMoreFilteredPosts(token: RealEndPoints.testingToken);
    }
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
          child: RefreshIndicator(
            onRefresh: () async {
              context
                  .read<FilteringCubit>()
                  .refreshFilteredPosts(token: RealEndPoints.testingToken);
            },
            child: SingleChildScrollView(
              controller: scrollController,
              scrollDirection: Axis.vertical,
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilteringTile(
                    filteringCubit: context.read<FilteringCubit>(),
                  ),
                  SizedBox(height: 16),
                  BlocBuilder<FilteringCubit, FilteringState>(
                    builder: (context, state) {
                      if (state is FilteredPostsIsLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FilteredPostsIsLoaded) {
                        if (state.filteredPosts.isNotEmpty) {
                          final newPosts = state.filteredPosts.where((newPost) {
                            return !posts.any((existingPost) =>
                                existingPost.id == newPost.id);
                          }).toList();
                          posts.addAll(newPosts);
                        }
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          scrollController.jumpTo(
                              scrollPosition); // Restore scroll position
                        });

                        if (posts.isEmpty) {
                          print('retrived data is empty ya 3m'); // Debug
                        }
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                  'Posts Filtered : ${state.filteredPosts.length}'),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.filteredPosts.length +
                                  (state.hasMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                print('Filtering State: $state');
                                if (index == state.filteredPosts.length) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                return FilteredPostCard(
                                  postOwnerId: posts[index].userId,
                                  title: posts[index].title,
                                  postOwner: posts[index].createdBy,
                                  date: posts[index].createdOn.toString(),
                                  content: posts[index].content,
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
                      } else if (state is FilteredPostsIsLoadingMore) {
                        return Center(child: CircularProgressIndicator());
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
