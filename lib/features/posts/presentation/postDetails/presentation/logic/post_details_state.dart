part of 'post_details_cubit.dart';

@immutable
sealed class PostDetailsState {}

final class PostDetailsInitial extends PostDetailsState {}

final class PostDetailsLoading extends PostDetailsState {}

final class PostDetailsLoaded extends PostDetailsState {
  final PostDetailsModel postDetails;
  PostDetailsLoaded(this.postDetails);
}

final class PostDetailsError extends PostDetailsState {
  final String message;
  PostDetailsError(this.message);
}

