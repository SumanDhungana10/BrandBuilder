import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
 

  HomepageCubit() : super(const HomepageState());

  void toggleSideBar() {
    emit(state.copyWith(isSideBarOpen: !state.isSideBarOpen));
  }
   
 

}
