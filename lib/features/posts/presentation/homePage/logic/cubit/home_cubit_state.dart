part of 'home_cubit_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeCubitInitial extends HomeState {}

class PostLoading extends HomeState {}

class PostLoaded extends HomeState {
  final List<PostEntity> posts;
  final int totalPosts;

  const PostLoaded(
    this.posts,
    this.totalPosts,
  );

  @override
  List<Object> get props => [
        posts,
        totalPosts,
      ];
}

class PostError extends HomeState {
  final String message;

  const PostError(this.message);

  @override
  List<Object> get props => [
        message,
      ];
}
