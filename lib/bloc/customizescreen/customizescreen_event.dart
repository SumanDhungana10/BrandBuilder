part of 'customizescreen_bloc.dart';

abstract class CustomizepageEvent extends Equatable {
  const CustomizepageEvent();

  @override
  List<Object> get props => [];
}
class AddStarterConversation extends CustomizepageEvent {
  final String question;

  const AddStarterConversation(this.question);

  @override
  List<Object> get props => [question];
}

class RemoveStarterConversation extends CustomizepageEvent {
  final int index;

  const RemoveStarterConversation(this.index);

  @override
  List<Object> get props => [index];
}

class UpdateAllStarterConversations extends CustomizepageEvent {
  final List<String> conversations;

  const UpdateAllStarterConversations(this.conversations);

  @override
  List<Object> get props => [conversations];
}
