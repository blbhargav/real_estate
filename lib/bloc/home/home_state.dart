part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState({this.screen = HomeNavItem.dashboard});
  final HomeNavItem screen;
  @override
  List<Object> get props => [screen];
}

final class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeUpdated extends HomeState {
  const HomeUpdated({super.screen = HomeNavItem.dashboard});
  @override
  List<Object> get props => [screen];
}
