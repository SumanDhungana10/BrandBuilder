import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/bloc/customizescreen/customizescreen_bloc.dart';
import 'package:krofile_ai/bloc/homescreen/homescreen_bloc.dart';
import 'package:krofile_ai/bloc/mylist/mylist_bloc.dart';
import 'package:krofile_ai/responsive.dart';
import 'package:krofile_ai/utils/skeleton.dart';
import 'package:krofile_ai/utils/text_parse.dart';
import 'package:krofile_ai/utils/typewriter_text.dart';
import 'package:krofile_ai/widgets/addto_mylist_alert.dart';
import 'package:krofile_ai/widgets/prefix_button.dart';
import 'package:krofile_ai/widgets/viewmore_feedback_alert.dart';
import 'package:share_plus/share_plus.dart';

class BusinessChat extends StatefulWidget {
  const BusinessChat({super.key, required this.scaffoldKey});
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<BusinessChat> createState() => _BusinessChatState();
}

class _BusinessChatState extends State<BusinessChat> {
  final TextEditingController _inputQuestion = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _textFocusNode.dispose();
    _inputQuestion.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BlocBuilder<BusinessResponseBloc, BusinessResponseState>(
                    builder: (context, state) {
                  final starterConversation = context
                      .watch<CustomizeScreenBloc>()
                      .state
                      .starterConversation;

                  // If there are more than 4 items, shuffle and take 4 randomly
                  // final displayedStarterConversations =
                  //     (starterConversation.length > 4)
                  //         ? (starterConversation.toList()..shuffle())
                  //             .take(4)
                  //             .toList()
                  //         : starterConversation;
                  final displayedStarterConversations =
                      (starterConversation.length > 4)
                          ? (starterConversation.toList()..shuffle())
                              .take(4)
                              .toList()
                          : (starterConversation.length == 3)
                              ? starterConversation.take(2).toList()
                              : starterConversation;

                  return (state.isQuestionProvided == false)
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: (starterConversation.isNotEmpty)
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/images/SquareLogo.png",
                                height: 80,
                                width: 80,
                              ),
                              const Text("How can I help you today?",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Color(0xFF151515),
                                      fontWeight: FontWeight.w700)),
                              BlocBuilder<CustomizeScreenBloc,
                                  CustomizeScreenState>(
                                builder: (context, state) {
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(24),
                                    gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:
                                          (displayedStarterConversations
                                                      .length ==
                                                  1)
                                              ? double.infinity
                                              : 620,
                                      mainAxisExtent: 90,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                    ),
                                    itemCount:
                                        displayedStarterConversations.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        customBorder: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        onTap: () {
                                          String question =
                                              displayedStarterConversations[
                                                      index]
                                                  .question;
                                          context
                                              .read<BusinessResponseBloc>()
                                              .add(HandleQuestionType());
                                          context
                                              .read<BusinessResponseBloc>()
                                              .add(AddQuestionAnswerList(
                                                  question));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xFFE5E5E5)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.all(24),
                                          child: (displayedStarterConversations
                                                      .length ==
                                                  1)
                                              ? Center(
                                                  child: Text(
                                                    displayedStarterConversations[
                                                            index]
                                                        .question,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xFF151515),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                )
                                              : Text(
                                                  displayedStarterConversations[
                                                          index]
                                                      .question,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color(0xFF151515),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      : const Expanded(child: ResponseUI());
                }),
              ],
            ),
          ),
          BlocBuilder<HomeScreenBloc, HomeScreenState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  if (Responsive.isDesktop(context)) {
                    context.read<HomeScreenBloc>().add(ToggleSideBar());
                  }
                  if (Responsive.isMobile(context)) {
                    widget.scaffoldKey.currentState!.openEndDrawer();
                  }
                },
                child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 22, 8, 22),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: const Color(0xFFE5E5E5), width: 1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: (Responsive.isDesktop(context))
                        ? (state.isSideBarOpen)
                            ? Image.asset(
                                "assets/images/Closesidebaricon.png",
                                height: 12,
                                width: 8,
                              )
                            : Image.asset(
                                "assets/images/Opensidebaricon.png",
                                height: 12,
                                width: 8,
                              )
                        : Image.asset(
                            "assets/images/Opensidebaricon.png",
                            height: 12,
                            width: 8,
                          )),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset("assets/images/Clearicon.png"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child:
                      BlocBuilder<BusinessResponseBloc, BusinessResponseState>(
                    builder: (context, state) {
                      // Update the controller's text if questionFromFAQ is not empty and differs from current text
                      if (state.questionFromFAQ.isNotEmpty &&
                          _inputQuestion.text != state.questionFromFAQ) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (_inputQuestion.text != state.questionFromFAQ) {
                            _inputQuestion.text = state.questionFromFAQ;
                          }
                        });
                      }

                      return BlocBuilder<BusinessResponseBloc,
                          BusinessResponseState>(
                        builder: (context, state) {
                          bool isAnimationCompleted =
                              state.questionAnswerList.isNotEmpty &&
                                  !state.questionAnswerList.last
                                      .isAnimationCompleted;

                          return TextFormField(
                            controller: _inputQuestion,
                            focusNode: _textFocusNode,
                            readOnly: isAnimationCompleted,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFF18C554)),
                              ),
                              prefixIcon: const PrefixButton(),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF54A5EA),
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: SvgPicture.asset(
                                        "assets/images/send.svg"),
                                    onPressed: () {
                                      if (_inputQuestion.text.isNotEmpty &&
                                          !isAnimationCompleted) {
                                        context
                                            .read<BusinessResponseBloc>()
                                            .add(ResetTextFieldController());
                                        context
                                            .read<BusinessResponseBloc>()
                                            .add(HandleQuestionType());
                                        context
                                            .read<BusinessResponseBloc>()
                                            .add(AddQuestionAnswerList(
                                                _inputQuestion.text));
                                        _inputQuestion.clear();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              hintText: 'Message Krofile...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: const Color(0xFFFFFFFF),
                              hoverColor: const Color(0xFFFFFFFF),
                            ),
                            onFieldSubmitted: (value) {
                              if (_inputQuestion.text.isNotEmpty &&
                                  !isAnimationCompleted) {
                                context
                                    .read<BusinessResponseBloc>()
                                    .add(ResetTextFieldController());
                                context
                                    .read<BusinessResponseBloc>()
                                    .add(HandleQuestionType());
                                context.read<BusinessResponseBloc>().add(
                                    AddQuestionAnswerList(_inputQuestion.text));
                                FocusScope.of(context)
                                    .requestFocus(_textFocusNode);
                                _inputQuestion.clear();
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  tooltip: "Explore",
                  onPressed: () {
                    context.go('/KrofileAI/explore');
                  },
                  icon: SvgPicture.asset("assets/images/apps.svg"),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(
                "Double-check important information as GPT can make mistakes.",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ResponseUI extends StatefulWidget {
  const ResponseUI({
    super.key,
  });

  @override
  State<ResponseUI> createState() => _ResponseUIState();
}

class _ResponseUIState extends State<ResponseUI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 35, bottom: 20),
      child: BlocBuilder<BusinessResponseBloc, BusinessResponseState>(
          buildWhen: (previous, current) =>
              previous.questionAnswerList != current.questionAnswerList,
          builder: (context, state) {
            final newList = state.questionAnswerList.toList();

            return ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: newList.length,
                itemBuilder: (context, index) {
                  final updateIndex = newList.length - index - 1;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xFFE5E5E5), width: 1)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              // padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFD4D4D4),
                                    width: 1,
                                  )),
                              child: const Icon(
                                Icons.person,
                                color: Color(0xFF603CFF),
                              ),
                            ), // Replace with your icon (if any
                            const SizedBox(width: 16),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 16),
                                child: Text(
                                  newList[updateIndex].question,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF151515),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            BlocListener<BusinessResponseBloc,
                                BusinessResponseState>(
                              listenWhen: (previous, current) =>
                                  previous.faqSavingStatus !=
                                  current.faqSavingStatus,
                              listener: (context, state) {
                                if (state.faqSavingStatus ==
                                    FAQSavingStatus.inProgress) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return const DynamicProgressDialog();
                                    },
                                  );
                                } else if (state.faqSavingStatus ==
                                        FAQSavingStatus.success ||
                                    state.faqSavingStatus ==
                                        FAQSavingStatus.error) {
                                  Navigator.of(context)
                                      .pop(); // Dismiss the dialog
                                }
                              },
                              child: IconButton(
                                  tooltip: "Add to FAQ",
                                  icon: SvgPicture.asset(
                                    "assets/images/arrow-up.svg",
                                  ),
                                  onPressed: (state.faq.length < 20)
                                      ? () {
                                          context
                                              .read<BusinessResponseBloc>()
                                              .add(SaveFaqQuestion(
                                                  newList[updateIndex]
                                                      .question));
                                          context
                                              .read<BusinessResponseBloc>()
                                              .add(GetFaq());
                                        }
                                      : null),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: Color(0xFFE5E5E5), width: 1),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/SquareLogo.png",
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(width: 32),
                            Expanded(
                              child: PromptResponse(
                                index: newList.length - index - 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          }),
    );
  }
}

class PromptResponse extends StatefulWidget {
  final int index;

  const PromptResponse({super.key, required this.index});

  @override
  State<PromptResponse> createState() => _PromptResponseState();
}

class _PromptResponseState extends State<PromptResponse>
    with TickerProviderStateMixin {
  final List<String> disLikeReport = [
    "Doesn't seem correct",
    "Wasn't useful to me",
    "This is inappropriate or upsetting",
    "Prefer a different approach",
    "Had trouble with my file",
    "More.."
  ];

  Future<void> _viewMoreFeedBack(int index, String answer) {
    return showDialog(
        barrierColor: const Color(0xFF000000).withOpacity(0.8),
        context: context,
        builder: (BuildContext context) {
          return ViewMoreFeedBack(responseIndex: index, answer: answer);
        });
  }

  Future<void> _addToMyList(String answer) {
    return showDialog(
        barrierColor: const Color(0xFF000000).withOpacity(0.8),
        context: context,
        builder: (BuildContext context) {
          return AddToMyList(answer: answer);
        });
  }

  void showThankYouMessage(int index) {
    context.read<BusinessResponseBloc>().add(CloseDislikeFeedback(index));
    context.read<BusinessResponseBloc>().add(CloseRegenerateFeedback(index));
    context.read<BusinessResponseBloc>().add(ShowThankYouMessage(index));
  }

  bool isRegenerating = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessResponseBloc, BusinessResponseState>(
      builder: (context, state) {
        final questionAnswer = state.questionAnswerList[widget.index];
        final answer = questionAnswer.answer;
        final isRegenerating = state.regeneratingIndices[widget.index] ?? false;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (questionAnswer.isLoading)
              for (int i = 0; i < 3; i++)
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Skeletal(
                    height: 16,
                    width: double.infinity,
                  ),
                )
            else if (questionAnswer.isNewResponse ||
                !questionAnswer.isAnimationCompleted)
              CustomAnimatedText(
                key: ValueKey(answer),
                text: answer,
                fontSize: 16,
                textColor: const Color(0xFF151515),
                index: widget.index,
                animationContext: AnimationContext.businessResponse,
              )
            else
              RichText(
                text: TextSpan(
                  children: convertToBoldText(answer,
                      fontSize: 16, color: const Color(0xFF151515)),
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            const SizedBox(
              height: 16,
            ),
            if (state.questionAnswerList[widget.index].isAnimationCompleted)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          tooltip: "Regenerate",
                          onPressed: questionAnswer.isLoading
                              ? null
                              : () {
                                  context
                                      .read<BusinessResponseBloc>()
                                      .add(HandleRegenerate(widget.index));
                                },
                          icon: const Icon(
                            Icons.replay_outlined,
                            size: 24,
                            color: Color(0xFF151515),
                          )),
                      IconButton(
                          tooltip: "Share",
                          onPressed: () {
                            Share.share(
                                state.questionAnswerList[widget.index].answer);
                          },
                          icon: const Icon(
                            Icons.share_outlined,
                            size: 24,
                            color: Color(0xFF151515),
                          )),
                      IconButton(
                          tooltip: "Copy",
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                    text: state.questionAnswerList[widget.index]
                                        .answer))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      duration: Duration(milliseconds: 500),
                                      content:
                                          Text('Copied to your clipboard!')));
                            });
                          },
                          icon: const Icon(
                            Icons.file_copy_outlined,
                            size: 24,
                            color: Color(0xFF151515),
                          )),
                      BlocBuilder<MylistBloc, MylistState>(
                        builder: (context, state) {
                          return IconButton(
                            tooltip: "Add to My List",
                            onPressed: () {
                              _addToMyList(answer);
                            },
                            icon: SvgPicture.asset(
                              "assets/images/Bookmark.svg",
                              height: 24,
                              width: 24,
                            ),
                          );
                        },
                      )
                    ],
                  ),
                  Row(
                    children: [
                      (state.isLikedPressed[widget.index] == null)
                          ? IconButton(
                              tooltip: "Like",
                              onPressed: (state
                                          .isDislikedPressed[widget.index] ==
                                      true)
                                  ? null
                                  : () {
                                      context.read<BusinessResponseBloc>().add(
                                          ResponseFeedback(
                                              "Like", questionAnswer.answer));
                                      showThankYouMessage(widget.index);
                                      context
                                          .read<BusinessResponseBloc>()
                                          .add(LikeFeedback(widget.index));
                                    },
                              icon: SvgPicture.asset(
                                "assets/images/thumbs-up.svg",
                              ),
                            )
                          : RotatedBox(
                              quarterTurns: 2,
                              child: IconButton(
                                tooltip: "Like",
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  "assets/images/thumbs-down.svg",
                                ),
                              ),
                            ),
                      (state.isDislikedPressed[widget.index] == null)
                          ? RotatedBox(
                              quarterTurns: 2,
                              child: IconButton(
                                tooltip: "Dislike",
                                onPressed: (state
                                            .isLikedPressed[widget.index] ==
                                        true)
                                    ? null
                                    : () {
                                        context
                                            .read<BusinessResponseBloc>()
                                            .add(DislikeFeedback(widget.index));
                                      },
                                icon: SvgPicture.asset(
                                  "assets/images/thumbs-up.svg",
                                ),
                              ),
                            )
                          : IconButton(
                              tooltip: "Dislike",
                              onPressed: () {},
                              icon: SvgPicture.asset(
                                "assets/images/thumbs-down.svg",
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            if (isRegenerating && questionAnswer.isAnimationCompleted)
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      border: Border.all(
                        color: const Color(0xFFE5E5E5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Was the response better or worse?",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF151515))),
                        Row(
                          children: [
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context.read<BusinessResponseBloc>().add(
                                          ResponseFeedback(
                                              "Better", questionAnswer.answer));
                                      showThankYouMessage(widget.index);
                                    },
                                    icon: const Icon(
                                      Icons.thumb_up_alt_outlined,
                                      size: 24,
                                    )),
                                const Text("Better",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF151515)))
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context.read<BusinessResponseBloc>().add(
                                          ResponseFeedback(
                                              "Worse", questionAnswer.answer));
                                      showThankYouMessage(widget.index);
                                    },
                                    icon: const Icon(
                                      Icons.thumb_down_alt_outlined,
                                      size: 24,
                                    )),
                                const Text("Worse",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF151515)))
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      context.read<BusinessResponseBloc>().add(
                                          CloseRegenerateFeedback(
                                              widget.index));
                                      showThankYouMessage(widget.index);
                                    },
                                    icon: const Icon(
                                      Icons.thumb_up_alt_outlined,
                                      size: 24,
                                    )),
                                const Text("Same",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF151515)))
                              ],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              context
                                  .read<BusinessResponseBloc>()
                                  .add(CloseRegenerateFeedback(widget.index));
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                  )),
            if (state.disLikedIndex[widget.index] == true)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    border: Border.all(
                      color: const Color(0xFFE5E5E5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tell us more:",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF151515)),
                            ),
                            IconButton(
                                onPressed: () {
                                  context
                                      .read<BusinessResponseBloc>()
                                      .add(CloseDislikeFeedback(widget.index));
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 24,
                                ))
                          ],
                        ),
                      ),
                      Wrap(
                        spacing: 24,
                        runSpacing: 20,
                        children: [
                          for (var item in disLikeReport)
                            ElevatedButton(
                              onPressed: () {
                                if (item == "More..") {
                                  _viewMoreFeedBack(
                                      widget.index, questionAnswer.answer);
                                } else {
                                  context.read<BusinessResponseBloc>().add(
                                      ResponseFeedback(
                                          item, questionAnswer.answer));
                                  showThankYouMessage(widget.index);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                textStyle: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF151515),
                                    fontWeight: FontWeight.w400),
                                padding: const EdgeInsets.all(24),
                                foregroundColor: const Color(0xFF151515),
                                side: const BorderSide(
                                    color: Color(0xFFD4D4D4), width: 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14)),
                              ),
                              child: Text(item),
                            )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            if (state.showThankYouMessage[widget.index] == true)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      border: Border.all(
                        color: const Color(0xFFE5E5E5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      'Thank you for your feedback',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF151515),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class DynamicProgressDialog extends StatefulWidget {
  const DynamicProgressDialog({super.key});

  @override
  DynamicProgressDialogState createState() => DynamicProgressDialogState();
}

class DynamicProgressDialogState extends State<DynamicProgressDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shadowColor: const Color(0xFF000000).withOpacity(0.2),
      backgroundColor: const Color(0xFFFAFAFA),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      contentPadding: const EdgeInsets.only(bottom: 0),
      titlePadding: const EdgeInsets.all(10),
      alignment: Alignment.topCenter,
      insetPadding: const EdgeInsets.only(top: 20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF18C554),
              size: 16,
            ),
          ),
          const Text(
            "Question has been added to FAQs successfully",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF151515)),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              size: 16,
            ),
          ),
        ],
      ),
      content: const LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E7BC8)),
      ),
    );
  }
}
