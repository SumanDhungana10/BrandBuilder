part of 'customizescreen_bloc.dart';

abstract class CustomizepageEvent extends Equatable {
  const CustomizepageEvent();

  @override
  List<Object> get props => [];
}
class FetchStarterConversations extends CustomizepageEvent {}
class DeleteStarterConversation extends CustomizepageEvent {
  final int index;

  const DeleteStarterConversation(this.index);

  @override
  List<Object> get props => [index];
}
class UpdateStarterConversations extends CustomizepageEvent {
 final int index;
  final String question;
  
    const UpdateStarterConversations(this.index, this.question);
  
    @override
    List<Object> get props => [index, question];
}
class UploadGeneralFile extends CustomizepageEvent {
  final PlatformFile file;

  const UploadGeneralFile(this.file);

  @override
  List<Object> get props => [file];
}
class ResetGeneralFileUploaded extends  CustomizepageEvent {}

class SaveStarterConversations extends CustomizepageEvent {
}
class ResetUpdateConversationStatus extends CustomizepageEvent {}