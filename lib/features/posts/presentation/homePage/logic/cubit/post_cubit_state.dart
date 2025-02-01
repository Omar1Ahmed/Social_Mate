part of 'post_cubit_cubit.dart';

sealed class PostCubitState extends Equatable {
  const PostCubitState();

  @override
  List<Object> get props => [];
}

final class PostCubitInitial extends PostCubitState {}

class PostInitial extends PostCubitState {}

class PostLoading extends PostCubitState {}

class PostLoaded extends PostCubitState {
  final List<PostEntity> posts;
  final int total;
  const PostLoaded(this.posts, this.total);
}

class PostError extends PostCubitState {
  final String message;
  const PostError(this.message);
}
