import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/core/entities/post_entity.dart';

part 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsCubit() : super(PostDetailsInitial());

   static int _PostId = 0;

  void setSelectedPost(int postId) {
    print('PostId: $postId');
    _PostId = postId;
  }


}
