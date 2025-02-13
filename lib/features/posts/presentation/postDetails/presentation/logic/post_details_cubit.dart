import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:social_media/core/shared/entities/post_entity.dart';
import 'package:social_media/core/error/errorResponseModel.dart';
import 'package:social_media/core/helper/Connectivity/connectivity_helper.dart';
import 'package:social_media/features/posts/data/model/entities/commentEntity.dart';

import 'package:social_media/features/posts/domain/repository/postDetails/postDetails_repository.dart';

part 'post_details_state.dart';

enum ReactionType { LIKE, DIS_LIKE }

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsRepository postDetailsRepository;

  PostDetailsCubit(this.postDetailsRepository) : super(PostDetailsInitial());

  TextEditingController createCommentController = TextEditingController();

  PostEntity? post;
  List<CommentEntity>? comments;
  static int _postId = 0;
  int? commentsCount;
  double? rateAverage;
  double selectedRatingValue = 0;
  FocusNode commentfocusNode = FocusNode();
  ReactionType? selectedReactionType;

  static void setSelectedPost(int postId) {
    _postId = postId;
  }

  Future<void> setRateAverage(int value) async {
    selectedRatingValue = value.toDouble();
    emit(SetPostRateLoading());
    try {
      final response = await postDetailsRepository.RatePost(_postId, value);
      if (response['statusCode'] == 204) {
        emit(SuccessPostRate());
      } else {
        selectedRatingValue = rateAverage ?? 0;
        emit(FailPostRate());
      }
    } catch (e) {
      selectedRatingValue = rateAverage ?? 0;
      emit(FailPostRate());
    }
  }

  Future<void> getPostDetails() async {
    bool isConnected = await ConnectivityHelper.isConnected();

    print('Is connected : ${isConnected}');

    try {
      emit(PostDetailsLoading());
      post = await postDetailsRepository.getPostDetails(_postId);

      emit(PostDetailsLoaded(post!));
    } catch (e, trace) {
      print(trace);
      emit(PostDetailsError(e.toString()));
    }
  }

  Future<void> getPostCommentsCount() async {
    print('commentsCount ');

    try {
      emit(CommentsCountLoading());
      commentsCount = await postDetailsRepository.getPostCommentsCount(_postId);
      print('commentsCount: $commentsCount');
      emit(CommentsCountLoaded());
    } catch (e, trace) {
      print(trace);
      emit(PostDetailsError(e.toString()));
    }
  }

  Future<void> getPostRateAverage() async {
    bool isConnected = await ConnectivityHelper.isConnected();

    print('Is connected Rate: ${isConnected}');
    try {
      emit(RatePostAverageLoading());
      rateAverage = await postDetailsRepository.getPostRateAverage(_postId);

      selectedRatingValue = rateAverage!;

      emit(RatePostAverageLoaded());
    } catch (e, trace) {
      print('rate Error ${e.toString()}');
      if (e.toString().contains('null')) {
        rateAverage = 0;
        selectedRatingValue = 0;
        emit(RatePostAverageLoaded());
      }
      print(trace);
      emit(PostDetailsError(e.toString()));
    }
  }

  Future<void> getPostComments() async {
    try {
      emit(CommentsLoading());
      comments = await postDetailsRepository.getPostComments(_postId);

      emit(CommentsLoaded());
    } catch (e, trace) {
      print('rate Error ${e.toString()}');
      print(trace);
      emit(PostDetailsError(e.toString()));
    }
  }

//  Future<void> giveReaction({
//   required int commentId,
//   required ReactionType reactionType,
//   required int index,
// }) async {
//   // Prevent duplicate reactions
//   if (selectedReactionType != reactionType) {
//     try {
//       emit(GiveReactionLoading());

//       // Call the repository method
//       final response = await postDetailsRepository.GiveReaction(
//           commentId, commentId, reactionType);

//       // Debug: Print the full response
//       print('Give Reaction Response: $response');

//       // Check the status code directly
//       if (response.containsKey('statusCode') && response['statusCode'] == 204) {
//         // Update the selected reaction type
//         selectedReactionType = reactionType;

//         // Update the UI for like/dislike count
//         if (reactionType == ReactionType.LIKE) {
//           comments![index].numOfLikes++;
//         } else {
//           comments![index].numOfDisLikes++;
//         }
//         emit(GiveReactionSuccess());
//       } else {
//         // Reset reaction type on failure
//         selectedReactionType = null;
//         emit(GiveReactionFail(
//             'Failed to React to The post (Status Code: ${response['statusCode']})'));
//       }
//     } catch (e) {
//       if (e is ErrorResponseModel) {
//         // Handle the "already reacted" case
//         if (e.message.toString().contains('already reacted')) {
//           selectedReactionType = reactionType;
//           emit(GiveReactionFail('You Already Reacted to this comment'));
//         } else {
//           emit(GiveReactionFail(e.message.toString()));
//         }
//       } else {
//         emit(GiveReactionFail(e.toString()));
//       }
//     }
//   } else {
//     emit(GiveReactionFail('You Already Reacted to this comment'));
//   }
// }

  //
  //
  Future<void> deleteComment(int commentId) async {
    commentfocusNode.unfocus();
    try {
      emit(deleteCommentLoading());
      final response =
          await postDetailsRepository.deleteComment(_postId, commentId);
      print('give reaction: $response');

      if (response['statusCode'] == 204) {
        emit(deleteCommentSuccess());
      } else {
        emit(deleteCommentFail('Failed to Delete to The post'));
      }
    } catch (e, trace) {
      if (e is ErrorResponseModel) {
        emit(deleteCommentFail(e.message.toString()));
      } else {
        emit(deleteCommentFail(e.toString()));
      }
    }
  }

  Future<void> createComment(BuildContext context) async {
    if (createCommentController.text.isNotEmpty) {
      try {
        emit(CommentsCreationLoading());

        final response = await postDetailsRepository.createComment(
            _postId, createCommentController.text);

        // Debug: Print the full response
        print('Create Comment Response: $response');

        // Check the status code directly
        if (response.containsKey('statusCode') &&
            response['statusCode'] == 200) {
          commentfocusNode.unfocus();
          createCommentController.clear();
          emit(CommentsCreated());
        } else {
          emit(CommentsError(
              'Failed to send Your Comment (Status Code: ${response['statusCode']})'));
        }
      } catch (e) {
        if (e is ErrorResponseModel) {
          emit(CommentsError(e.message.toString()));
        } else {
          emit(CommentsError(e.toString()));
        }
      }
    } else {
      emit(CommentsError('Please Enter Your Comment'));
    }
  }
}
