import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
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

  FocusNode commentfocusNode = FocusNode();

  PostEntity? post;
  List<CommentEntity>? comments;
  static int _postId = 0;
  double? rateAverage;
  double selectedRatingValue = 0;

  // Pagination
  int? commentsCount;
  int _currentPage = 0;
  int _pageSize = 3;
  bool hasMoreComments = true;
  bool isLoading = false;




  static void setSelectedPost(int postId) {
    _postId = postId;
  }

  Future<void> setRateAverage(int value) async {
    selectedRatingValue = value.toDouble();
    emit(SetPostRateLoading());
    try{
      final response = await postDetailsRepository.RatePost(_postId, value);
      if (response['statusCode'] == 204) {
        emit(SuccessPostRate());
      } else {
        selectedRatingValue = rateAverage ?? 0;
        emit(FailPostRate());
      }
    }catch(e){
      selectedRatingValue = rateAverage ?? 0;
      emit(FailPostRate());
    }
  }

  Future<void> getPostDetails() async {

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


    try {
      emit(CommentsCountLoading());
      commentsCount = await postDetailsRepository.getPostCommentsCount(_postId);

      emit(CommentsCountLoaded());
    } catch (e, trace) {
      print(trace);
      emit(PostDetailsError(e.toString()));
    }
  }


  Future<void> getPostRateAverage() async {

    try {
      emit(RatePostAverageLoading());
      rateAverage = await postDetailsRepository.getPostRateAverage(_postId);

      print('rate Average ${rateAverage}');

      rateAverage ??= 0;

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


  Future<void> getPostComments({int? pageOffset = null, int? pageSize = null }) async {
  print('get comments');

    if (!hasMoreComments || isLoading) return;

    isLoading = true;
    try {
      emit(CommentsLoading());
      final newComments = await postDetailsRepository.getPostComments(postId: _postId, pageOffset: pageOffset?? _currentPage, pageSize: pageSize??_pageSize);



      print(newComments[0]);
      // print('comments length ${comments!.length} $_currentPage $commentsCount ${newComments.length}');

      if(newComments.isEmpty) {
        hasMoreComments = false;
      }else{
        comments ??= [];
        comments!.addAll(newComments);

        _currentPage++;
        print('has more comments ${(_currentPage * _pageSize) < commentsCount!}');
        hasMoreComments = (_currentPage * _pageSize) < commentsCount!;
      }

      emit(CommentsLoaded());
    } catch (e, trace) {
      print('rate Error ${e.toString()}');
      print(trace);
      emit(PostDetailsError(e.toString()));
    }finally{
      isLoading = false;
    }
  }
  //
  // Future<void> giveReaction({
  //   required int commentId,
  //   required ReactionType reactionType,
  //   required int index
  // }) async {
  //
  //   if(selectedReactionType != reactionType) {
  //
  //    try {
  //     emit(GiveReactionLoading());
  //     final response = await postDetailsRepository.GiveReaction(
  //         _PostId, commentId, reactionType);
  //     print('give reaction: $response');
  //     if (response['statusCode'] == 204) {
  //       selectedReactionType = reactionType;
  //       if (reactionType == ReactionType.LIKE) {
  //         comments![index].numOfLikes++;
  //       } else {
  //         comments![index].numOfDisLikes++;
  //       }
  //       emit(GiveReactionSuccess());
  //     } else {
  //       selectedReactionType = null;
  //       emit(GiveReactionFail('Failed to React to The post'));
  //     }
  //   } catch (e, trace) {
  //     if (e is ErrorResponseModel) {
  //       if (e.message.toString().contains(' already reacted')) {
  //         selectedReactionType = reactionType;
  //         emit(GiveReactionFail('Already Reacted to this comment'));
  //       } else {
  //         emit(GiveReactionFail(e.message.toString()));
  //       }
  //     } else {
  //       emit(GiveReactionFail(e.toString()));
  //     }
  //   }
  // }else{
  //     emit(GiveReactionFail('You Already Reacted to this comment'));
  //   }
  // }
  //
  //
  Future<void> deleteComment(int commentId) async {
    commentfocusNode.unfocus();
    try {
      emit(deleteCommentLoading());
      final response = await postDetailsRepository.deleteComment(
          _postId, commentId);
      print('give reaction: $response');

      if (response['statusCode'] == 204) {
        comments!.removeWhere((comment) => comment.id == commentId);
        emit(deleteCommentSuccess(commentId));
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

        if (response['data'] is int ) {
          commentfocusNode.unfocus();
          createCommentController.clear();
          emit(CommentsCreated());
        } else {

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


  Future<void> refreshPostDetails() async {
    try {


      _currentPage = 0;
      comments = null;
      commentsCount = null;
      rateAverage = null;
      hasMoreComments = true;
      post = null;
      selectedRatingValue= 0;


      await getPostDetails();
    } catch (e) {
      emit(PostDetailsError(e.toString()));
    }
  }

}