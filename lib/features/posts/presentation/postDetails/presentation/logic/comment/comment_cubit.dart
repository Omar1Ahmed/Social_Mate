import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_media/core/error/errorResponseModel.dart';
import 'package:social_media/features/posts/data/model/entities/commentEntity.dart';
import 'package:social_media/features/posts/domain/repository/postDetails/postDetails_repository.dart';
import 'package:social_media/features/posts/presentation/postDetails/presentation/logic/post_details_cubit.dart';

part 'comment_state.dart';


class CommentCubit extends Cubit<CommentState> {
  PostDetailsRepository postDetailsRepository;
  CommentEntity comment;
  CommentCubit({required this.postDetailsRepository, required this.comment}) : super(CommentInitial());



  ReactionType? selectedReactionType;

  Future<void> giveReaction({
  required int postId,
  required ReactionType reactionType,

}) async {

  if(selectedReactionType != reactionType) {

    try {
      emit(GiveReactionLoading());
      final response = await postDetailsRepository.GiveReaction(
          postId, comment.id, reactionType);
      print('give reaction: $response');
      if (response['statusCode'] == 204) {

        if(reactionType == ReactionType.LIKE){
          comment.numOfLikes++;
        }else{
          comment.numOfDisLikes++;
        }
        if(selectedReactionType == ReactionType.LIKE){
          comment.numOfLikes--;
        }else if (selectedReactionType == ReactionType.DIS_LIKE){
          comment.numOfDisLikes--;
        }
        selectedReactionType = reactionType;
        emit(GiveReactionSuccess());
      } else {
        selectedReactionType = null;
        emit(GiveReactionFail('Failed to React to The post'));
      }
    } catch (e, trace) {
      if (e is ErrorResponseModel) {
        if (e.message.toString().contains('already reacted')) {
          selectedReactionType = reactionType;
          emit(GiveReactionFail('Already Reacted to this comment'));

          return;
        } else {
          emit(GiveReactionFail(e.message.toString()));
        }
      } else {
        emit(GiveReactionFail(e.toString()));
      }
      selectedReactionType = null;
    }
  }else{
    emit(GiveReactionFail('You Already Reacted to this comment'));
  }
}




}


