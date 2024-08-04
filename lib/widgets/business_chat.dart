import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/bloc/customizescreen/customizescreen_bloc.dart';
import 'package:krofile_ai/bloc/homescreen/homescreen_bloc.dart';
import 'package:krofile_ai/responsive.dart';
import 'package:krofile_ai/screen/explore_screen.dart';
import 'package:krofile_ai/services/business_chat_services.dart';
import 'package:krofile_ai/widgets/response_ui.dart';
import 'package:krofile_ai/widgets/viewfaq_alert.dart';
import 'package:popover/popover.dart';

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

  Future<void> _viewFaq() {
    return showDialog(
        barrierColor: const Color(0xFF000000).withOpacity(0.8),
        context: context,
        builder: (BuildContext context) {
          return const ViewFAQ();
        });
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
                  return (state.isQuestionType == false)
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
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
                                  itemCount: state.starterConversation
                                      .length, // Replace with your actual item count
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      customBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      onTap: () {
                                        String question =
                                            state.starterConversation[index];
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
                                          state.starterConversation[index],
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
                                    //   }
                                    // );
                                  },
                                );
                              }),
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
                            // Check again to avoid race conditions
                            _inputQuestion.text = state.questionFromFAQ;
                          }
                        });
                      }

                      return BlocBuilder<BusinessResponseBloc,
                          BusinessResponseState>(
                        builder: (context, state) {
                          bool isLastAnswerLoading =
                              state.questionAnswerList.isNotEmpty &&
                                  state.questionAnswerList.last.isloading;

                          return TextFormField(
                            controller: _inputQuestion,
                            focusNode: _textFocusNode,
                            readOnly: isLastAnswerLoading,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFF18C554)),
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/images/arrow-up.svg",
                                  ),
                                  onPressed: () {
                                    if (state.faq.isNotEmpty) {
                                      _viewFaq();
                                    } else {
                                      showPopover(
                                          context: context,
                                          barrierColor: Colors.transparent,
                                          direction: PopoverDirection.top,
                                          bodyBuilder: (context) {
                                            return Container(
                                              padding: const EdgeInsets.all(16),
                                              width: 450,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Row(
                                                        children: [
                                                          Icon(
                                                            Icons.info,
                                                            color: Colors.green,
                                                          ),
                                                          Text("Instructions",
                                                              style: TextStyle(
                                                                  fontSize: 24,
                                                                  color: Color(
                                                                      0xFF151515),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ],
                                                      ),
                                                      IconButton(
                                                        icon: const Icon(
                                                            Icons.close),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  const Text(
                                                      "To our FAQ section! To add a question, click on the plus icon (+) next to existing questions. You can add up to 10 questions. Need to find the FAQ? Click the plus icon (+) on the search field. Questions? Reach out to us. Happy FAQ-ing!")
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                  },
                                ),
                              ),
                              suffixIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF18C554),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: SvgPicture.asset(
                                        "assets/images/send.svg",
                                      ),
                                      onPressed: () {
                                        if (_inputQuestion.text.isNotEmpty) {
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
                                  )),
                              hintText: 'Message Krofile...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            onFieldSubmitted: (value) {
                              if (_inputQuestion.text.isNotEmpty) {
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
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ExploreScreen()));
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
