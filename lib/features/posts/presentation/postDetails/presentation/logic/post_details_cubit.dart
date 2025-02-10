import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/core/entities/post_entity.dart';
import 'package:social_media/core/helper/Connectivity/connectivity_helper.dart';
import 'package:social_media/features/posts/data/model/postDetails/postDetails_reponse.dart';
import 'package:social_media/features/posts/domain/repository/postDetails/postDetails_repository.dart';

part 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsRepository postDetailsRepository;

  PostDetailsCubit(this.postDetailsRepository) : super(PostDetailsInitial());

  late PostDetailsModel post;
   static int _PostId = 0;

  static void setSelectedPost(int postId) {
    print('PostId: $postId');
    _PostId = postId;
  }

  Future<void> getPostDetails() async {

    bool isConnected = await ConnectivityHelper.isConnected();

    print('Is connected : ${isConnected}');

    try{
     emit(PostDetailsLoading());
     post = await postDetailsRepository.getPostDetails(_PostId);

      emit(PostDetailsLoaded(post));
    }catch(e,trace){
      print(trace);
      emit(PostDetailsError(e.toString()));
    }
  }



}
