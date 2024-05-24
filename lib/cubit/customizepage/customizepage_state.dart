part of 'customizepage_cubit.dart';

class CustomizepageState extends Equatable {
  final List<String> starterConversation;
  const CustomizepageState(
      {this.starterConversation = const [
        'Generate strategies to effectively scale my social media marketing efforts.',
        'How brands can effectively leverage online advertising?',
        'Generate top five content ideas for my business',
        'Give me 5 subject lines for my email marketing campaign.'
      ]});

  CustomizepageState copyWith({
    List<String>? starterConversation,
  }) {
    return CustomizepageState(
      starterConversation: starterConversation ?? this.starterConversation,
    );
  }

  @override
  List<Object> get props => [ starterConversation];
}
