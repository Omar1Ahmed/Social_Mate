import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entity/post_entity.dart';
import '../../../../domain/repository/post_repository.dart';

part 'home_cubit_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.postRepository) : super(HomeCubitInitial());
  final PostRepository postRepository;
  Future<void> getPosts() async {
    await Future.delayed(Duration(seconds: 3));
    emit(PostLoading());
    final response = await postRepository.getPosts();

    emit(PostLoaded(response.$1, response.$2));
  }
}
