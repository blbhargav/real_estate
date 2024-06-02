import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../enums/search_option.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  void update({SearchOption searchOption = SearchOption.cosyAreas}) {
    emit(SearchUpdate(searchOption: searchOption));
  }
}
