import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/bloc/homescreen/homescreen_bloc.dart';
import 'package:krofile_ai/data/alllist.dart';

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
      child: BlocBuilder<HomeScreenBloc, HomeScreenState>(
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
                        child: BlocBuilder<BusinessResponseBloc,
                            BusinessResponseState>(
                          builder: (context, state) {
                            return ListView.builder(
                              itemCount: selectedList.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xFFE5E5E5),
                                        width: 1,
                                      ),
                                    )),
                                    child: Text(
                                      selectedList[index],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  onTap: () {
                                    context
                                        .read<BusinessResponseBloc>()
                                        .add(HandleQuestionType());
                                    context.read<BusinessResponseBloc>().add(
                                        AddQuestionAnswerList(
                                            selectedList[index]));
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
              : BlocBuilder<BusinessResponseBloc, BusinessResponseState>(
                  builder: (context, state) {
                    final historyList = state.historyList.reversed.toList();
                    return Container(
                      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFFFFF),
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
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<HomeScreenBloc>()
                                      .add(ToggleHistory());
                                  context.pop();
                                },
                                icon: const Icon(Icons.close),
                              )
                            ],
                          ),
                          (state.historyList.isEmpty)
                              ? const Text("No history found")
                              : Expanded(
                                  child: ListView.builder(
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
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Text(
                                            historyList[index][
                                                'Question'], // Accessing the 'Question' field
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Text(
                                            historyList[index][
                                                'Answer'], // Accessing the 'Answer' field
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
                                                .read<BusinessResponseBloc>()
                                                .add(ResetQuestionAnswerList());
                                            context
                                                .read<BusinessResponseBloc>()
                                                .add(HandleQuestionType());

                                            context
                                                .read<BusinessResponseBloc>()
                                                .add(ShowHistoryData(
                                                  historyList[index][
                                                      'Question']!, // Passing the question
                                                  historyList[index][
                                                      'Answer']!, // Passing the answer
                                                ));
                                          },
                                        ),
                                      );
                                    },
                                  ),
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
