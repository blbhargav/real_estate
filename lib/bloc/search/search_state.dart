part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState({this.searchOption = SearchOption.cosyAreas});
  final SearchOption searchOption;
  @override
  List<Object> get props => [searchOption];
}

final class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchUpdate extends SearchState {
  const SearchUpdate({super.searchOption = SearchOption.cosyAreas});
  @override
  List<Object> get props => [searchOption];
}
