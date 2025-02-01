import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'filtering_state.dart';

class FilteringCubit extends Cubit<FilteringState> {
  FilteringCubit() : super(FilteringInitial());
}
