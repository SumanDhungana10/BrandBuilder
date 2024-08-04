import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/bloc/homescreen/homescreen_bloc.dart';
import 'package:krofile_ai/data/allList.dart';

class SideBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideBar({super.key, required this.scaffoldKey});
  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
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
    dropDownValue = dropDownItems[Random().nextInt(dropDownItems.length)];
  }

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

    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, state) {
        return (!state.isHistoryOpen)
            ? Container(
                // key: widget.scaffoldKey,
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  border: Border(
                    left: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: DropdownButton<String>(
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
                    ),
                    Expanded(
                      child: BlocBuilder<BusinessResponseBloc,
                          BusinessResponseState>(
                        builder: (context, state) {
                          bool isLastAnswerLoading =
                              state.questionAnswerList.isNotEmpty &&
                                  state.questionAnswerList.last.isloading;

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
                                    child: Text(selectedList[index])),
                                onTap: isLastAnswerLoading
                                    ? null
                                    : () {
                                        context
                                            .read<BusinessResponseBloc>()
                                            .add(HandleQuestionType());
                                        context
                                            .read<BusinessResponseBloc>()
                                            .add(AddQuestionAnswerList(
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
                            IconButton(
                              onPressed: () {
                                context
                                    .read<HomeScreenBloc>()
                                    .add(ToggleHistory());
                              },
                              icon: const Icon(Icons.close),
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
                                              .read<BusinessResponseBloc>()
                                              .add(ResetQuestionAnswerList());
                                          context
                                              .read<BusinessResponseBloc>()
                                              .add(HandleQuestionType());

                                          context
                                              .read<BusinessResponseBloc>()
                                              .add(ShowHistoryData(
                                                  historyList[index]
                                                      ['question']!,
                                                  historyList[index]
                                                      ['answer']!));
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
    );
  }
}
