import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/cubit/homepage_cubit.dart';
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
    // Select a random item from dropDownItems and assign it to dropDownValue
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

    return BlocBuilder<HomepageCubit, HomepageState>(
      builder: (context, state) {
        return Drawer(
          key: widget.scaffoldKey,
          // padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          // decoration: const BoxDecoration(
          //   color: Colors.amber,
          //   border: Border(
          //     left: BorderSide(color: Color(0xFFE5E5E5), width: 1),
          //   ),
          // ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                child: DropdownButton<String>(
                  underline: Container(),
                  focusColor: Colors.white,
                  value: dropDownValue,
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
                child: ListView.builder(
                  itemCount: selectedList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                            .read<HomepageCubit>()
                            .getQuestionList(selectedList[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
