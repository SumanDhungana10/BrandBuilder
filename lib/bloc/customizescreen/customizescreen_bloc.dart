import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'customizescreen_event.dart';
part 'customizescreen_state.dart';

class CustomizeScreenBloc extends Bloc<CustomizepageEvent, CustomizeScreenState> {
  CustomizeScreenBloc() : super( CustomizeScreenState()) {
    on<AddStarterConversation>(_onAddStarterConversation);
    on<RemoveStarterConversation>(_onRemoveStarterConversation);
    on<UpdateAllStarterConversations>(_onUpdateAllStarterConversations);
  }

  void _onAddStarterConversation(
      AddStarterConversation event, Emitter<CustomizeScreenState> emit) {
    final newStarterConversation = [...state.starterConversation];
    if (event.question.isNotEmpty) {
      newStarterConversation.add(event.question);
    }
    emit(state.copyWith(starterConversation: newStarterConversation));
  }

  void _onRemoveStarterConversation(
      RemoveStarterConversation event, Emitter<CustomizeScreenState> emit) {
    final newStarterConversation = [...state.starterConversation];
    newStarterConversation.removeAt(event.index);
    emit(state.copyWith(starterConversation: newStarterConversation));
  }

  void _onUpdateAllStarterConversations(
      UpdateAllStarterConversations event, Emitter<CustomizeScreenState> emit) {
    final newStarterConversation =
        event.conversations.where((element) => element.isNotEmpty).toList();
    emit(state.copyWith(starterConversation: newStarterConversation));
  }
}
