import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/core/Responsive/ui_component/info_widget.dart';
import 'package:social_media/core/theming/styles.dart';
import 'package:social_media/features/filtering/presentation/cubit/filtering_cubit.dart';
import 'package:social_media/features/filtering/presentation/widgets/filtered_post_card.dart';
import 'package:social_media/features/filtering/presentation/widgets/filtering_tile.dart';

import '../../../../core/entities/post_entity.dart';

class FilteringScreen extends StatefulWidget {
  const FilteringScreen({super.key});

  @override
  State<FilteringScreen> createState() => _FilteringScreenState();
}

class _FilteringScreenState extends State<FilteringScreen> {
  List<PostEntity> posts = [];
  @override
  Widget build(BuildContext context) {
    final filteringCubit = context.read<FilteringCubit>();
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
            scrollDirection: Axis.vertical,
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilteringTile(
                  filteringCubit: filteringCubit,
                ),
                SizedBox(height: 16),
                BlocBuilder<FilteringCubit, FilteringState>(
                  builder: (context, state) {
                    if (state is FilteredPostsIsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FilteredPostsIsLoaded) {
                      posts = state.filteredPosts;
                      if (posts.isEmpty) {
                        print('retrived data is empty ya 3m');
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.filteredPosts.length,
                        itemBuilder: (context, index) {
                          print('Filtering State: $state');
                          return FilteredPostCard(
                            title: posts[index].title,
                            postOwner: posts[index].createdBy.fullName,
                            date: posts[index].createdOn.toString(),
                            content: posts[index].content,
                          );
                        },
                      );
                    } else if (state is FilteredPostsHasError) {
                      return Text(state.message);
                    } else {
                      return Center(
                        child: Text('No posts'),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
