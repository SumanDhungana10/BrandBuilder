import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/homepage/homepage_cubit.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';
import 'package:krofile_ai/widgets/response_ui.dart';
import 'package:krofile_ai/widgets/viewfaqalert.dart';

class AiChatting extends StatefulWidget {
  const AiChatting({super.key});

  @override
  State<AiChatting> createState() => _AiChattingState();
}

class _AiChattingState extends State<AiChatting> {
  final TextEditingController _inputQuestion = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _textFocusNode.dispose();
    _inputQuestion.dispose();
  }

  List<String> initialView = [
    'Generate strategies to effectively scale my social media marketing efforts.',
    'How brands can effectively leverage online advertising?',
    'Generate top five content ideas for my business',
    'Give me 5 subject lines for my email marketing campaign.'
  ];
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
                BlocBuilder<ResponsepageCubit, ResponsepageState>(
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
                              Flexible(
                                child: GridView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(24),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      mainAxisExtent: 100,
                                    ),
                                    itemCount: initialView
                                        .length, // Replace with your actual item count
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          context
                                              .read<ResponsepageCubit>()
                                              .handelQuestionType();
                                          context
                                              .read<ResponsepageCubit>()
                                              .addQuestionAnswerList(
                                                  initialView[index]);
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
                                            initialView[index],
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
                                    }),
                              ),
                            ],
                          ),
                        )
                      : const Expanded(child: ResponseUI());
                }),
              ],
            ),
          ),
          BlocBuilder<HomepageCubit, HomepageState>(
            builder: (context, state) {
              return IconButton(
                style: IconButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    side: const BorderSide(color: Color(0xFFE5E5E5), width: 1),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8)))),
                icon: (state.isSideBarOpen)
                    ? Image.asset("assets/images/Vectorright.png")
                    : Image.asset("assets/images/Vectorleft.png"),
                onPressed: () {
                  context.read<HomepageCubit>().toggleSideBar();
                },
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Image.asset("assets/images/image32.png"),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: BlocBuilder<ResponsepageCubit, ResponsepageState>(
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

                  return TextFormField(
                    controller: _inputQuestion,
                    focusNode: _textFocusNode,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(width: 1),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/images/arrow-up.svg",
                          ),
                          onPressed: () {
                            _viewFaq();
                          },
                        ),
                      ),
                      suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xFF7B5AFF),
                                  Color(0xFF4A25E1),
                                ],
                                stops: [0.263, 0.864],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: SvgPicture.asset(
                                "assets/images/send.svg",
                              ),
                              onPressed: () {
                                if (_inputQuestion.text.isNotEmpty) {
                                  context
                                      .read<ResponsepageCubit>()
                                      .resetTextFeildController();
                                  context
                                      .read<ResponsepageCubit>()
                                      .handelQuestionType();
                                  context
                                      .read<ResponsepageCubit>()
                                      .addQuestionAnswerList(
                                          _inputQuestion.text);
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
                            .read<ResponsepageCubit>()
                            .resetTextFeildController();
                        context.read<ResponsepageCubit>().handelQuestionType();
                        context
                            .read<ResponsepageCubit>()
                            .addQuestionAnswerList(_inputQuestion.text);
                        FocusScope.of(context).requestFocus(_textFocusNode);

                        _inputQuestion.clear();
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/images/apps.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
