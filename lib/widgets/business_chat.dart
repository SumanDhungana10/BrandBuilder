import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/bloc/customizescreen/customizescreen_bloc.dart';
import 'package:krofile_ai/bloc/homescreen/homescreen_bloc.dart';
import 'package:krofile_ai/responsive.dart';
import 'package:krofile_ai/widgets/prefixButton.dart';
import 'package:krofile_ai/widgets/response_ui.dart';

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
                  final displayedStarterConversations =
                      (starterConversation.length > 4)
                          ? (starterConversation.toList()..shuffle())
                              .take(4)
                              .toList()
                          : starterConversation;

                  return (state.isQuestionType == false)
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
                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 620,
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
                                          child: Text(
                                            displayedStarterConversations[index]
                                                .question,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
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
                                "assets/images/Vectorright.png",
                                height: 12,
                                width: 8,
                              )
                            : Image.asset(
                                "assets/images/Vectorleft.png",
                                height: 12,
                                width: 8,
                              )
                        : Image.asset(
                            "assets/images/Vectorleft.png",
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
                  icon: Image.asset("assets/images/image32.png"),
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
