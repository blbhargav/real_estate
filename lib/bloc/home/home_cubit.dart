import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/enums/home_nav_item.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void update({HomeNavItem screen = HomeNavItem.dashboard}) {
    emit(HomeUpdated(screen: screen));
  }
}
