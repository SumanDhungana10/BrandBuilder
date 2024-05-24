import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/dislikefeedback/dislikefeedback_cubit.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';
import 'package:krofile_ai/widgets/viewmorefeedbackalert.dart';

class ResponseUI extends StatefulWidget {
  const ResponseUI({
    super.key,
    // required this.questionAnswerList,
  });
  // final List<Map<String, dynamic>> questionAnswerList;

  @override
  State<ResponseUI> createState() => _ResponseUIState();
}

class _ResponseUIState extends State<ResponseUI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: BlocBuilder<ResponsepageCubit, ResponsepageState>(
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
                            const SizedBox(width: 20),
                            Flexible(
                              child: Text(
                                newList[updateIndex].question,
                                // widget.questionAnswerList[updateIndex]
                                //     ['question'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF151515),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            IconButton(
                                icon: SvgPicture.asset(
                                  "assets/images/arrow-up.svg",
                                ),
                                onPressed: (state.faq.length < 20)
                                    ? () {
                                        final String question =
                                            newList[updateIndex].question;
                                        context
                                            .read<ResponsepageCubit>()
                                            .addFaq(question);
                                        showDialog(
                                            context: context,
                                            barrierColor:
                                                const Color(0xFF000000)
                                                    .withOpacity(0.0),
                                            barrierDismissible: true,
                                            builder: (context) {
                                              return AlertDialog(
                                                shadowColor:
                                                    const Color(0xFF000000)
                                                        .withOpacity(0.2),
                                                backgroundColor:
                                                    const Color(0xFFFAFAFA),
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    4))),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        bottom: 0),
                                                titlePadding:
                                                    const EdgeInsets.all(10),
                                                alignment: Alignment.topCenter,
                                                insetPadding:
                                                    const EdgeInsets.only(
                                                        top: 20),
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 5),
                                                      child: Icon(
                                                        Icons
                                                            .check_circle_rounded,
                                                        color:
                                                            Color(0xFF18C554),
                                                        size: 16,
                                                      ),
                                                    ),
                                                    const Text(
                                                      "Question has been added to FAQs successfully",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color(
                                                              0xFF151515)),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      icon: const Icon(
                                                        Icons.close,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                content:
                                                    const LinearProgressIndicator(
                                                  value: 0.7,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xFF18C554)),
                                                ),
                                              );
                                            });
                                      }
                                    : null),
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

class _PromptResponseState extends State<PromptResponse> {
  final List<String> disLikeReport = [
    "Doesn't seem correct",
    "Wasn't useful to me",
    "This is inappropriate or upsetting",
    "Prefer a different approach",
    "Had trouble with my file",
    "More.."
  ];

  final Map<int, Timer> _thankYouTimers = {};

  Future<void> _viewMoreFeedBack() {
    return showDialog(
        barrierColor: const Color(0xFF000000).withOpacity(0.8),
        context: context,
        builder: (BuildContext context) {
          return const ViewMoreFeedBack();
        });
  }

  void _showThankYouMessage(int index) {
    context.read<DislikefeedbackCubit>().showThankYouMessage(index);
    context.read<DislikefeedbackCubit>().closeDisLikeFeedback(index);
    context.read<DislikefeedbackCubit>().closeRegenerateFeedBack(index);

    // Cancel any existing timer for this index
    _thankYouTimers[index]?.cancel();

    // Start a new timer for the thank you message
    _thankYouTimers[index] = Timer(const Duration(milliseconds: 2000), () {
      context.read<DislikefeedbackCubit>().closeThankYouMessage(index);
    });
  }

  @override
  void dispose() {
    // Cancel all timers when the widget is disposed
    for (var timer in _thankYouTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResponsepageCubit, ResponsepageState>(
      // buildWhen: (previous, current) =>
      //     previous.questionAnswerList != current.questionAnswerList,
      builder: (context, state) {
        final answer = state.questionAnswerList[widget.index].answer;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              answer,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF151515),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context
                              .read<ResponsepageCubit>()
                              .regenerateAnswer(widget.index);
                          context
                              .read<DislikefeedbackCubit>()
                              .regenerateFeedBack(widget.index);
                        },
                        icon: const Icon(
                          Icons.replay_outlined,
                          size: 24,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.share_outlined,
                          size: 24,
                        )),
                    IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                                  text: state
                                      .questionAnswerList[widget.index].answer))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Duration(milliseconds: 200),
                                    content:
                                        Text('Copied to your clipboard!')));
                          });
                        },
                        icon: const Icon(
                          Icons.file_copy_outlined,
                          size: 24,
                        )),
                    IconButton(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                        "assets/images/Bookmark.svg",
                        height: 24,
                        width: 24,
                      ),
                    )
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
                        onPressed: () {
                          context
                              .read<DislikefeedbackCubit>()
                              .disLikeFeedback(widget.index);
                        },
                        icon: const Icon(
                          Icons.thumb_down_alt_outlined,
                          size: 24,
                        )),
                  ],
                )
              ],
            ),
            BlocBuilder<DislikefeedbackCubit, DislikefeedbackState>(
              builder: (context, state) {
                return (state.regeneratedIndex[widget.index] == true)
                    ? Padding(
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
                                            _showThankYouMessage(widget.index);
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
                                          onPressed: () {},
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
                                          onPressed: () {},
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
                                        .read<DislikefeedbackCubit>()
                                        .closeRegenerateFeedBack(widget.index);
                                  },
                                  icon: const Icon(Icons.close))
                            ],
                          ),
                        ))
                    : Container();
              },
            ),
            BlocBuilder<DislikefeedbackCubit, DislikefeedbackState>(
              builder: (context, state) {
                return (state.disLikedIndex[widget.index] == true)
                    ? Padding(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                              .read<DislikefeedbackCubit>()
                                              .closeDisLikeFeedback(
                                                  widget.index);
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
                                          _viewMoreFeedBack();
                                        } else {
                                          _showThankYouMessage(widget.index);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0xFF151515),
                                            fontWeight: FontWeight.w400),
                                        padding: const EdgeInsets.all(24),
                                        foregroundColor:
                                            const Color(0xFF151515),
                                        side: const BorderSide(
                                            color: Color(0xFFD4D4D4), width: 1),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(14)),
                                      ),
                                      child: Text(item),
                                    ),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    : Container();
              },
            ),
            BlocBuilder<DislikefeedbackCubit, DislikefeedbackState>(
              builder: (context, state) {
                return (state.showThankYouMessage[widget.index] == true)
                    ? Padding(
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
                      )
                    : Container();
              },
            ),
          ],
        );
      },
    );
  }
}
