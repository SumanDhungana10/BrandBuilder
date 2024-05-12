import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krofile_ai/cubit/homepage_cubit.dart';
import 'package:krofile_ai/widgets/response_ui.dart';
import 'package:krofile_ai/widgets/side_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> initialView = [
    'Generate strategies to effectively scale my social media marketing efforts.',
    'How brands can effectively leverage online advertising?',
    'Generate top five content ideas for my business',
    'Give me 5 subject lines for my email marketing campaign.'
  ];
  final TextEditingController _inputQuestion = TextEditingController();
  final List<String> _questionList = [];
  final List<String> _answerList = [
    'Generate strategies to effectively scale my social media marketing efforts.',
    'How brands can effectively leverage online advertising?',
    'Generate top five content ideas for my business',
    'Give me 5 subject lines for my email marketing campaign.'
  ];
  final List<Map<String, dynamic>> _questionAnswerList = [];
  bool isQuestionTyped = false;
  void _handelquestion() {
    setState(() {
      _questionList.add(_inputQuestion.text);
      _questionAnswerList.add({
        'question': _inputQuestion.text,
        'answer': _answerList[_questionList.length % _answerList.length],
      });
      isQuestionTyped = true;
      _inputQuestion.clear();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _inputQuestion.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset("assets/images/logo.png", width: 50, height: 50),
                const Text("Krofile AI",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xFF15141A),
                        fontWeight: FontWeight.w600)),
              ],
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF151515),
                        fontWeight: FontWeight.w400),
                    padding: const EdgeInsets.all(8),
                    foregroundColor: const Color(0xFF151515),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFE5E5E5), width: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/images/apps.svg",
                    height: 16,
                    width: 16,
                  ),
                  label: const Text("Explore"),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF151515),
                        fontWeight: FontWeight.w400),
                    padding: const EdgeInsets.all(8),
                    foregroundColor: const Color(0xFF151515),
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFFE5E5E5), width: 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/images/Bookmark.svg",
                    height: 16,
                    width: 16,
                  ),
                  label: const Text("My List"),
                ),
                const ThreeDotMenu(),
              ],
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: BlocBuilder<HomepageCubit, HomepageState>(
                  buildWhen: (previous, current) =>
                      previous.questionAnswerList !=
                          current.questionAnswerList ||
                      previous.isQuestionType != current.isQuestionType,
                  builder: (context, state) {
                    return Column(
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
                        if (state.isQuestionType == true)
                          // if (isQuestionTyped == true)
                          const ChattingView(
                              // questionAnswerList: _questionAnswerList
                              ),
                        Padding(
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
                                            shape: BoxShape
                                                .circle, // Shape of the container
                                          ),
                                          child: IconButton(
                                            icon: SvgPicture.asset(
                                              "assets/images/send.svg",
                                            ),
                                            onPressed: () {
                                              if (_inputQuestion
                                                  .text.isNotEmpty) {
                                                // _handelquestion();
                                                context
                                                    .read<HomepageCubit>()
                                                    .handelQuestionType();
                                                // setState(() {
                                                //   isQuestionTyped = true;
                                                // });
                                                context
                                                    .read<HomepageCubit>()
                                                    .getQuestionList(
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
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                onPressed: () {},
                                icon:
                                    SvgPicture.asset("assets/images/apps.svg"),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Double-check important information as GPT can make mistakes.",
                            style: TextStyle(
                                color: Color(0xFF73767B),
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              BlocBuilder<HomepageCubit, HomepageState>(
                builder: (context, state) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin:
                        EdgeInsets.only(right: state.isSideBarOpen ? 320.0 : 0),
                    child: IconButton(
                      style: IconButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          // backgroundColor: Colors.amber,
                          side: const BorderSide(
                              color: Color(0xFFE5E5E5), width: 1),
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
                    ),
                  );
                },
              ),
            ],
          ),
          // BlocBuilder<HomepageCubit, HomepageState>(
          //   builder: (context, state) {
          //     return AnimatedPositioned(
          //       duration: const Duration(milliseconds: 300),
          //       top: 0,
          //       bottom: 0,
          //       right: state.isSideBarOpen ? 0 : -320,
          //       child: const SideBar(),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class ThreeDotMenu extends StatelessWidget {
  const ThreeDotMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      onSelected: (int result) {},
      itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
        const PopupMenuItem<int>(
          value: 1,
          child: ListTile(
            title: Text('History '),
          ),
        ),
        const PopupMenuItem<int>(
          value: 2,
          child: ListTile(
            title: Text('Clear All Chat'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 3,
          child: ListTile(
            title: Text('Customize'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 4,
          child: ListTile(
            title: Text('Incognito Mode'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 5,
          child: ListTile(
            title: Text('Delete All Search History'),
          ),
        ),
        const PopupMenuItem<int>(
          value: 6,
          child: ListTile(
            title: Text('Feedback'),
          ),
        ),
      ],
    );
  }
}
