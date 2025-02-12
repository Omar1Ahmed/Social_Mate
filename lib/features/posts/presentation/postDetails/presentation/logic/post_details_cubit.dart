import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:social_media/core/shared/entities/post_entity.dart';
import 'package:social_media/core/error/errorResponseModel.dart';
import 'package:social_media/core/helper/Connectivity/connectivity_helper.dart';
import 'package:social_media/features/posts/data/model/entities/commentEntity.dart';

import 'package:social_media/features/posts/domain/repository/postDetails/postDetails_repository.dart';

part 'post_details_state.dart';

enum ReactionType {LIKE,DIS_LIKE}

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsRepository postDetailsRepository;

  PostDetailsCubit(this.postDetailsRepository) : super(PostDetailsInitial());

  TextEditingController createCommentController = TextEditingController();

  PostEntity? post;
  List<CommentEntity>? comments;
  static int _PostId = 0;
  int? commentsCount;
  double? RateAverage;
  double SelectedRatingValue = 0;
  ReactionType? selectedReactionType;

  static void setSelectedPost(int postId) {
    print('PostId: $postId');
    _PostId = postId;
  }

  Future<void> setRateAverage(int value) async {
    SelectedRatingValue = value.toDouble();
    emit(SetPostRateLoading());
    final response = await postDetailsRepository.RatePost(_PostId, value);
    if (response['statusCode'] == 204) {
      emit(SuccessPostRate());
    } else {
      SelectedRatingValue = RateAverage ?? 0;
      emit(FailPostRate());
    }
  }

  Future<void> getPostDetails() async {
    bool isConnected = await ConnectivityHelper.isConnected();

    print('Is connected : ${isConnected}');

    try {
      emit(PostDetailsLoading());
      post = await postDetailsRepository.getPostDetails(_PostId);

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
      commentsCount = await postDetailsRepository.getPostCommentsCount(_PostId);
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
      RateAverage = await postDetailsRepository.getPostRateAverage(_PostId);

      SelectedRatingValue = RateAverage!;

      emit(RatePostAverageLoaded());
    } catch (e, trace) {
      print('rate Error ${e.toString()}');
      if (e.toString().contains('null')) {
        RateAverage = 0;
        SelectedRatingValue = 0;
        emit(RatePostAverageLoaded());
      }
      print(trace);
      emit(PostDetailsError(e.toString()));
    }
  }


  Future<void> getPostComments() async {
    bool isConnected = await ConnectivityHelper.isConnected();

    print('Is connected Rate: ${isConnected}');

    try {
      emit(CommentsLoading());
      comments = await postDetailsRepository.getPostComments(_PostId);

      emit(CommentsLoaded());
    } catch (e, trace) {
      print('rate Error ${e.toString()}');
      print(trace);
      emit(PostDetailsError(e.toString()));
    }
  }

  Future<void> giveReaction({
    required int commentId,
    required ReactionType reactionType,
  }) async {
    try {
      emit(GiveReactionLoading());
      final response = await postDetailsRepository.GiveReaction(
          _PostId, commentId, reactionType);
      print('give reaction: $response');
      if (response['statusCode'] == 204) {
        selectedReactionType = reactionType;

        emit(GiveReactionSuccess());
      } else {
        selectedReactionType = null;
        emit(GiveReactionFail('Failed to React to The post'));
      }
    } catch (e, trace) {
      if (e is ErrorResponseModel) {
        if (e.message.toString().contains(' already reacted')) {
          selectedReactionType = reactionType;
          emit(GiveReactionFail('Already Reacted to this comment'));
        } else {
          emit(GiveReactionFail(e.message.toString()));
        }
      } else {
        emit(GiveReactionFail(e.toString()));
      }
    }
  }


  Future<void> deleteComment(int commentId) async {
    try {
      emit(deleteCommentLoading());
      final response = await postDetailsRepository.deleteComment(
          _PostId, commentId);
      print('give reaction: $response');

      if (response['statusCode'] == 204) {
        emit(deleteCommentSuccess());
      } else {
        selectedReactionType = null;
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
            _PostId, createCommentController.text);

        if (response['statusCode'] == 200) {
          FocusScope.of(context).unfocus();
          createCommentController.clear();
            emit(CommentsCreated());
        } else {
          selectedReactionType = null;
          emit(CommentsError('Failed to send Your Comment'));
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