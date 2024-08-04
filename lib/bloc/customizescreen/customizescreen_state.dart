part of 'customizescreen_bloc.dart';

class CustomizeScreenState extends Equatable {
  final List<String> starterConversation;
  const CustomizeScreenState(
      {this.starterConversation = const [
        'Generate strategies to effectively scale my social media marketing efforts.',
        'How brands can effectively leverage online advertising?',
        'Generate top five content ideas for my business',
        'Give me 5 subject lines for my email marketing campaign.'
      ]});

  CustomizeScreenState copyWith({
    List<String>? starterConversation,
  }) {
    return CustomizeScreenState(
      starterConversation: starterConversation ?? this.starterConversation,
    );
  }

  @override
  List<Object> get props => [starterConversation];
}

