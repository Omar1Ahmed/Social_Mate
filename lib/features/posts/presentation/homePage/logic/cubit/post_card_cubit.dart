import 'package:flutter_bloc/flutter_bloc.dart';

class PostCardCubit extends Cubit<bool> {
  PostCardCubit() : super(true); 

  void toggleExpansion() {
    emit(!state); 
  }
}