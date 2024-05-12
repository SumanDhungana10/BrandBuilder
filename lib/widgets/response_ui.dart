import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/cubit/homepage_cubit.dart';

class ChattingView extends StatefulWidget {
  const ChattingView({
    super.key,
    // required this.questionAnswerList,
  });
  // final List<Map<String, dynamic>> questionAnswerList;

  @override
  State<ChattingView> createState() => _ChattingViewState();
}

class _ChattingViewState extends State<ChattingView> {
  final List<String> _recomendationList = [
    "Tell me more",
    "What type of content resonates with my target audience?",
    "How do I measure the success of my social media campaigns?",
    "Should I use paid advertising on social media?"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          BlocBuilder<HomepageCubit, HomepageState>(
              // buildWhen: (previous, current) =>
              //     previous.questionAnswerList != current.questionAnswerList,
              builder: (context, state) {
            return ListView.builder(
                // physics:
                //     const NeverScrollableScrollPhysics(), // Disable inner ListView scrolling

                shrinkWrap: true,
                reverse: true,
                itemCount: state.questionAnswerList.length,
                // itemCount: widget.questionAnswerList.length,
                itemBuilder: (context, index) {
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
                            const SizedBox(width: 20),
                            Text(
                              state.questionAnswerList[index]['question'],
                              // widget.questionAnswerList[index]
                              //     ['question'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF151515),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                              "assets/images/logo.png",
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.questionAnswerList[index]['answer'],
                                    // widget.questionAnswerList[index]
                                    //     ['answer'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF151515),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.repeat,
                                                size: 24,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.share_outlined,
                                                size: 24,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.file_copy_outlined,
                                                size: 24,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.bookmark_border_outlined,
                                                size: 24,
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.thumb_up_alt_outlined,
                                                size: 24,
                                              )),
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.thumb_down_alt_outlined,
                                                size: 24,
                                              )),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                });
          }),
          // Column(
          //   children: List.generate(
          //     4,
          //     (index) => Container(
          //       padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          //       decoration: const BoxDecoration(
          //         border: Border(
          //           bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
          //         ),
          //       ),
          //       child: ListTile(
          //         title: Text(_recomendationList[index]),
          //         trailing: IconButton(
          //           onPressed: () {},
          //           icon: const Icon(
          //             Icons.arrow_forward_ios,
          //             size: 24,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
