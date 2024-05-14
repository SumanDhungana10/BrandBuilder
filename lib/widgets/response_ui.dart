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
  final List<String> _disLikeReport = [
    "Doesn't seem correct",
    "Wasn't useful to me",
    "This is inappropriate or upsetting",
    "Prefer a different approach",
    "Had trouble with my file",
    "More.."
  ];
  Future<void> _viewMoreFeedBack() {
    return showDialog(
        barrierColor: const Color(0xFF000000).withOpacity(0.8),
        context: context,
        builder: (BuildContext context) {
          return const ViewMoreFeedBack();
        });
  }

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
                                newList[updateIndex]['question'],
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
                              onPressed: () {
                                final String question =
                                    newList[updateIndex]['question'];
                                context
                                    .read<ResponsepageCubit>()
                                    .addFaq(question);
                                showDialog(
                                    context: context,
                                    barrierColor: const Color(0xFF000000)
                                        .withOpacity(0.0),
                                    barrierDismissible: false,
                                    builder: (context) {
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
                                        Navigator.of(context).pop(true);
                                      });
                                      return AlertDialog(
                                        shadowColor: const Color(0xFF000000)
                                            .withOpacity(0.2),
                                        backgroundColor:
                                            const Color(0xFFFAFAFA),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        contentPadding:
                                            const EdgeInsets.only(bottom: 0),
                                        titlePadding: const EdgeInsets.all(10),
                                        alignment: Alignment.topCenter,
                                        insetPadding:
                                            const EdgeInsets.only(top: 20),
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5),
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
                                          value: 0.7,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Color(0xFF18C554)),
                                        ),
                                      );
                                    });
                              },
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
  bool isfeedbackopen = false;
  @override
  Widget build(BuildContext context) {
    print("widget.index: ${widget.index}");
    return BlocBuilder<ResponsepageCubit, ResponsepageState>(
      buildWhen: (previous, current) =>
          previous.questionAnswerList != current.questionAnswerList,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.questionAnswerList[widget.index]['answer'],
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          // context.read()<ResponsepageCubit>().regenerateAnswer(
                          //     widget.index,
                          //     state.questionAnswerList[widget.index]
                          //         ['question']);
                          BlocProvider.of<ResponsepageCubit>(context)
                              .regenerateAnswer(
                                  widget.index,
                                  state.questionAnswerList[widget.index]
                                      ['question']);
                        },
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
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                                  text: state.questionAnswerList[widget.index]
                                      ['answer']))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    duration: Duration(milliseconds: 200),
                                    content:
                                        Text('Copied to your clipboard !')));
                          });
                        },
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
                        onPressed: () {
                          // context
                          //     .read<
                          //         DislikefeedbackCubit>()
                          //     .disLikeFeedback(index);
                          setState(() {
                            isfeedbackopen = !isfeedbackopen;
                          });
                        },
                        icon: const Icon(
                          Icons.thumb_down_alt_outlined,
                          size: 24,
                        )),
                  ],
                )
              ],
            ),
            if (isfeedbackopen) const Text("hello"),
            // BlocBuilder<DislikefeedbackCubit,
            //     DislikefeedbackState>(
            //   builder: (context, state) {
            //     return (state.disLikedIndex[index] ??
            //             false)
            //         ? Padding(
            //             padding: const EdgeInsets.only(
            //                 top: 20),
            //             child: Container(
            //               padding:
            //                   const EdgeInsets.fromLTRB(
            //                       16, 24, 16, 24),
            //               decoration: BoxDecoration(
            //                 color:
            //                     const Color(0xFFFAFAFA),
            //                 border: Border.all(
            //                   color:
            //                       const Color(0xFFE5E5E5),
            //                   width: 1,
            //                 ),
            //                 borderRadius:
            //                     BorderRadius.circular(14),
            //               ),
            //               child: Column(
            //                 children: [
            //                   Padding(
            //                     padding:
            //                         const EdgeInsets.only(
            //                             bottom: 24),
            //                     child: Row(
            //                       mainAxisAlignment:
            //                           MainAxisAlignment
            //                               .spaceBetween,
            //                       children: [
            //                         const Text(
            //                           "Tell us more:",
            //                           style: TextStyle(
            //                               fontSize: 18,
            //                               fontWeight:
            //                                   FontWeight
            //                                       .w500,
            //                               color: Color(
            //                                   0xFF151515)),
            //                         ),
            //                         IconButton(
            //                             onPressed: () {
            //                               context
            //                                   .read<
            //                                       DislikefeedbackCubit>()
            //                                   .closeDisLikeFeedback(
            //                                       index);
            //                             },
            //                             icon: const Icon(
            //                               Icons.close,
            //                               size: 24,
            //                             ))
            //                       ],
            //                     ),
            //                   ),
            //                   Wrap(
            //                     spacing: 30,
            //                     runSpacing: 20,
            //                     children: [
            //                       for (var item
            //                           in _disLikeReport)
            //                         ElevatedButton(
            //                           onPressed: () {
            //                             if (item ==
            //                                 "More..") {
            //                               _viewMoreFeedBack();
            //                             }
            //                           },
            //                           style:
            //                               ElevatedButton
            //                                   .styleFrom(
            //                             textStyle: const TextStyle(
            //                                 fontSize: 16,
            //                                 color: Color(
            //                                     0xFF151515),
            //                                 fontWeight:
            //                                     FontWeight
            //                                         .w400),
            //                             padding:
            //                                 const EdgeInsets
            //                                     .all(24),
            //                             foregroundColor:
            //                                 const Color(
            //                                     0xFF151515),
            //                             // backgroundColor: Colors.white
            //                             side: const BorderSide(
            //                                 color: Color(
            //                                     0xFFD4D4D4),
            //                                 width: 1),
            //                             shape: RoundedRectangleBorder(
            //                                 borderRadius:
            //                                     BorderRadius
            //                                         .circular(
            //                                             14)),
            //                           ),
            //                           child: Text(item),
            //                         ),
            //                     ],
            //                   )
            //                 ],
            //               ),
            //             ),
            //           )
            //         : Container();
            //   },
            // )
          ],
        );
      },
    );
  }
}
