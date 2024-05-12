import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/homepage_cubit.dart';
import 'package:krofile_ai/widgets/response_ui.dart';

class AiChatting extends StatefulWidget {
  const AiChatting({super.key});

  @override
  State<AiChatting> createState() => _AiChattingState();
}

class _AiChattingState extends State<AiChatting> {
  final TextEditingController _inputQuestion = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _inputQuestion.dispose();
  }

  List<String> initialView = [
    'Generate strategies to effectively scale my social media marketing efforts.',
    'How brands can effectively leverage online advertising?',
    'Generate top five content ideas for my business',
    'Give me 5 subject lines for my email marketing campaign.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: BlocBuilder<HomepageCubit, HomepageState>(
              builder: (context, state) {
                return  Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.isQuestionType == false)
                      // if (isQuestionTyped == false)
                      Image.asset(
                        "assets/images/logo.png",
                        height: 80,
                        width: 80,
                      ),
                    if (state.isQuestionType == false)
                      // if (isQuestionTyped == false)
                      const Text("How can I help you today?",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF151515),
                              fontWeight: FontWeight.w700)),
                    if (state.isQuestionType == false)
                      // if (isQuestionTyped == false)
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
                                      .read<HomepageCubit>()
                                      .handelQuestionType();
                                  context
                                      .read<HomepageCubit>()
                                      .getQuestionList(initialView[index]);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xFFE5E5E5)),
                                    borderRadius: BorderRadius.circular(10),
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
                    if (state.isQuestionType == true) const ChattingView(),
                  ],
                );
              },
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
              child: TextFormField(
                controller: _inputQuestion,
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
                      onPressed: () {},
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
                          shape: BoxShape.circle, // Shape of the container
                        ),
                        child: IconButton(
                          icon: SvgPicture.asset(
                            "assets/images/send.svg",
                          ),
                          onPressed: () {
                            if (_inputQuestion.text.isNotEmpty) {
                              // _handelquestion();
                              context
                                  .read<HomepageCubit>()
                                  .handelQuestionType();
                              // setState(() {
                              //   isQuestionTyped = true;
                              // });
                              context
                                  .read<HomepageCubit>()
                                  .getQuestionList(_inputQuestion.text);
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
                    // _handelquestion();
                    context.read<HomepageCubit>().handelQuestionType();
                    // setState(() {
                    //   isQuestionTyped = true;
                    // });
                    context
                        .read<HomepageCubit>()
                        .getQuestionList(_inputQuestion.text);
                    _inputQuestion.clear();
                  }
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
