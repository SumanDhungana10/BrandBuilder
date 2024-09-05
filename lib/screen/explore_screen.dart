import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:krofile_ai/bloc/explore/explore_bloc.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/responsive.dart';
import 'package:krofile_ai/widgets/back_button.dart';
import 'package:krofile_ai/widgets/explorepage_desktop_view.dart';
import 'package:krofile_ai/widgets/explorepage_mobile_view.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with TickerProviderStateMixin {
  int? _hoveredIndex;
  final TextEditingController _inputQuestion = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _textFocusNode.dispose();
    _inputQuestion.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ExploreBloc>().add(FetchExploreCategories());
    _textFocusNode.addListener(() {
      if (!_textFocusNode.hasFocus) {
        context.read<BusinessResponseBloc>().add(ResetTextFieldController());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFFAFAFA),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // if (Responsive.isDeskstop(context))
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1.0))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 12),
              child: Row(
                children: [
                  const OneBackButton(),
                  const SizedBox(width: 24),
                  Flexible(
                      fit: FlexFit.loose,
                      child: TextFormField(
                        controller: _inputQuestion,
                        focusNode: _textFocusNode,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xFF18C554)),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF54A5EA),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon:
                                    SvgPicture.asset("assets/images/send.svg"),
                                onPressed: () {
                                  if (_inputQuestion.text.isNotEmpty) {
                                    context
                                        .read<BusinessResponseBloc>()
                                        .add(ResetTextFieldController());
                                    context
                                        .read<BusinessResponseBloc>()
                                        .add(HandleQuestionType());
                                    context.read<BusinessResponseBloc>().add(
                                        AddQuestionAnswerList(
                                            _inputQuestion.text));
                                    _inputQuestion.clear();
                                    context.pop();
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
                          if (_inputQuestion.text.isNotEmpty) {
                            context
                                .read<BusinessResponseBloc>()
                                .add(ResetTextFieldController());
                            context
                                .read<BusinessResponseBloc>()
                                .add(HandleQuestionType());
                            context.read<BusinessResponseBloc>().add(
                                AddQuestionAnswerList(_inputQuestion.text));
                            FocusScope.of(context).requestFocus(_textFocusNode);
                            _inputQuestion.clear();
                            context.pop();
                          }
                        },
                      ))
                ],
              ),
            ),
          ),
          // if (Responsive.isMobile(context))
          //   Container(
          //     decoration: const BoxDecoration(
          //         border: Border(
          //             bottom:
          //                 BorderSide(color: Color(0xFFE5E5E5), width: 1.0))),
          //     child: Padding(
          //       padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          //       child: Row(
          //         children: [
          //           IconButton(
          //             onPressed: () {
          //               context.pop();
          //             },
          //             icon: const Icon(Icons.arrow_back_ios,
          //                 size: 16, color: Color(0xFF73767B)),
          //           ),
          //           const SizedBox(width: 4),
          //           Flexible(
          //             fit: FlexFit.loose,
          //             child: TextField(
          //               decoration: InputDecoration(
          //                 contentPadding: const EdgeInsets.all(8),
          //                 hintText: 'Message Krofile...',
          //                 hintStyle: const TextStyle(
          //                   fontSize: 12,
          //                   color: Colors.grey,
          //                   fontWeight: FontWeight.w400,
          //                 ),
          //                 focusedBorder: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(10),
          //                   borderSide: const BorderSide(
          //                     width: 1,
          //                     color: Colors.grey,
          //                   ),
          //                 ),
          //                 disabledBorder: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(10),
          //                   borderSide: const BorderSide(
          //                     width: 1,
          //                     color: Colors.grey,
          //                   ),
          //                 ),
          //                 enabledBorder: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(10),
          //                   borderSide: const BorderSide(
          //                     width: 1,
          //                     color: Colors.grey,
          //                   ),
          //                 ),
          //                 border: OutlineInputBorder(
          //                   borderRadius: BorderRadius.circular(10),
          //                   borderSide: const BorderSide(
          //                     width: 1,
          //                     color: Colors.grey,
          //                   ),
          //                 ),
          //                 suffixIcon: Padding(
          //                   padding: const EdgeInsets.all(8),
          //                   child: IconButton(
          //                     style: IconButton.styleFrom(
          //                         padding: const EdgeInsets.all(3.6),
          //                         backgroundColor: const Color(0xFF54A5EA),
          //                         shape: const CircleBorder()),
          //                     icon: SvgPicture.asset(
          //                       "assets/images/send.svg",
          //                     ),
          //                     onPressed: () {},
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          Expanded(
            child: BlocBuilder<ExploreBloc, ExploreState>(
              builder: (context, state) {
                if (state.isCategoriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return (!state.showSubCategory)
                      ? Padding(
                          padding: const EdgeInsets.only(left: 32, top: 32),
                          child: SingleChildScrollView(
                            child: Wrap(
                              runSpacing: 12,
                              spacing: 12,
                              children: [
                                for (int index = 0;
                                    index < state.categories.length;
                                    index++)
                                  MouseRegion(
                                    onEnter: (_) {
                                      setState(() {
                                        _hoveredIndex = index;
                                      });
                                    },
                                    onExit: (_) {
                                      setState(() {
                                        _hoveredIndex = null;
                                      });
                                    },
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context
                                            .read<ExploreBloc>()
                                            .add(HandelCategoryButton(index));
                                        context
                                            .read<ExploreBloc>()
                                            .add(ReorderCategories(index));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: _hoveredIndex == index
                                            ? const Color(0xFF54A5EA)
                                            : const Color(0xFFFFFFFF),
                                        foregroundColor: _hoveredIndex == index
                                            ? const Color(0xFFFFFFFF)
                                            : const Color(0xFF73767B),
                                        padding: const EdgeInsets.all(20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          side: const BorderSide(
                                              color: Colors.grey, width: 1.0),
                                        ),
                                      ),
                                      child: Text(
                                        state.categories[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )
                      : (Responsive.isDesktop(context))
                          ? const ExplorePageDeskTop()
                          : const ExplorePgaeMobileView();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
