import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customizepage_state.dart';

class CustomizepageCubit extends Cubit<CustomizepageState> {
  CustomizepageCubit() : super(const CustomizepageState());

  void addStarterConversation(String question) {
    final newStarterConversation = [...state.starterConversation];
    if (question != '') {
      newStarterConversation.add(question);
    }
    emit(state.copyWith(starterConversation: newStarterConversation));
  }

  void removeStarterConversation(int index) {
    final newStarterConversation = [...state.starterConversation];
    newStarterConversation.removeAt(index);
    emit(state.copyWith(starterConversation: newStarterConversation));
  }

  void updateAllStarterConversations(List<String> conversations) {
    final x = conversations.where((element) => element.isNotEmpty).toList();
    emit(state.copyWith(starterConversation: x));
  }
}
