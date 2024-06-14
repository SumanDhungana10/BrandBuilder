import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/homepage_popupmenu/homepage_popup_cubit.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';
import 'package:krofile_ai/data/alllist.dart';
import 'package:krofile_ai/widgets/response_page_ui.dart';

class SibeBarDrawer extends StatefulWidget {
  const SibeBarDrawer({super.key});

  @override
  State<SibeBarDrawer> createState() => _SibeBarDrawerState();
}

class _SibeBarDrawerState extends State<SibeBarDrawer> {
  List<String> dropDownItems = [
    'Official',
    'Popular',
    'For You',
    'Customer Acquisition',
    'Customer Retention'
  ];

  String dropDownValue = ''; // Initialize dropDownValue

  @override
  void initState() {
    super.initState();
    // Select a random item from dropDownItems and assign it to dropDownValue
    dropDownValue = dropDownItems[Random().nextInt(dropDownItems.length)];
  }

  bool isHistoryon = false;

  @override
  Widget build(BuildContext context) {
    List<String> selectedList = [];
    switch (dropDownValue) {
      case 'Popular':
        selectedList = popular;
        break;
      case 'For You':
        selectedList = forYou;
        break;
      case 'Customer Acquisition':
        selectedList = customerAcquisition;
        break;
      case 'Customer Retention':
        selectedList = customerRetentionQuestions;
        break;
      case 'Official':
        selectedList = official;
        break;
      default:
        selectedList = [];
    }

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(0)),
      ),
      child: BlocBuilder<ThreedotCubit, ThreedotState>(
        builder: (context, state) {
          return (!state.isHistoryOpen)
              ? Container(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFFF),

                    // color: Colors.white,
                    border: Border(
                      left: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton<String>(
                        underline: Container(),
                        focusColor: Theme.of(context).scaffoldBackgroundColor,
                        value: dropDownValue,
                        icon: SvgPicture.asset(
                          "assets/images/fe_arrow-right.svg",
                          width: 16,
                          height: 16,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropDownValue = newValue!;
                          });
                        },
                        items: dropDownItems
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Expanded(
                        child:
                            BlocBuilder<ResponsepageCubit, ResponsepageState>(
                          builder: (context, state) {
                            return ListView.builder(
                              itemCount: selectedList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 10, 0, 10),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xFFE5E5E5),
                                          width: 1,
                                        ),
                                      )),
                                      child: Text(selectedList[index])),
                                  onTap: () {
                                    context
                                        .read<ResponsepageCubit>()
                                        .handelQuestionType();
                                    context
                                        .read<ResponsepageCubit>()
                                        .addQuestionAnswerList(
                                            selectedList[index]);
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : BlocBuilder<ResponsepageCubit, ResponsepageState>(
                  builder: (context, state) {
                    final historyList = state.historyList.reversed.toList();
                    return Container(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      decoration: const BoxDecoration(
                        // color: Colors.amber,
                        border: Border(
                          left: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("History",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF15141A))),
                              BlocBuilder<ThreedotCubit, ThreedotState>(
                                builder: (context, state) {
                                  return IconButton(
                                    onPressed: () {
                                      context
                                          .read<ThreedotCubit>()
                                          .toggleHistory();
                                    },
                                    icon: const Icon(Icons.close),
                                  );
                                },
                              ),
                            ],
                          ),
                          Expanded(
                            child: (state.historyList.isNotEmpty)
                                ? ListView.builder(
                                    itemCount: historyList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        decoration: const BoxDecoration(
                                            border: Border(
                                          bottom: BorderSide(
                                            color: Color(0xFFE5E5E5),
                                            width: 1,
                                          ),
                                        )),
                                        child: ListTile(
                                          title: Text(
                                            historyList[index]['question']!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Text(
                                            historyList[index]['answer']!,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          trailing: const Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                            color: Color(0xFF73767B),
                                          ),
                                          onTap: () {
                                            context
                                                .read<ResponsepageCubit>()
                                                .resetQuestionAnswerList();
                                            context
                                                .read<ResponsepageCubit>()
                                                .handelQuestionType();

                                            context
                                                .read<ResponsepageCubit>()
                                                .showhistoyData(
                                                    historyList[index]
                                                        ['question']!,
                                                    historyList[index]
                                                        ['answer']!);
                                          },
                                        ),
                                      );
                                    },
                                  )
                                : const Center(child: Text("No History")),
                          )
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
