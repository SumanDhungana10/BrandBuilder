import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';
import 'package:krofile_ai/data/alllist.dart';
import 'package:krofile_ai/screen/homepage.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  bool showallCategory = false;
  String selectedCategory = '';
  List<String> selectedQuestions = [];
  int activeIndex = 0;
  PageController _pageViewController = PageController();
  late TabController _tabController;

  void selectCategory(String category, int index) {
    setState(() {
      selectedCategory = category;
      selectedQuestions = exploreQuestion
          .firstWhere((element) => element['category'] == category)['questions']
          .cast<String>();
      activeIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
    _pageViewController.addListener(() {
      setState(() {
        activeIndex = _pageViewController.page!.round();
      });
    });
    selectCategory(exploreQuestion[0]['category'],
        0); // Selecting the first category initially
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body:
          // SingleChildScrollView(
          // child:
          Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFF73767B), width: 1.0))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 12),
              child: Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                      icon: const Icon(Icons.arrow_back_ios,
                          size: 16, color: Color(0xFF73767B)),
                      label: const Text("Back",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF73767B),
                              fontWeight: FontWeight.w400))),
                  const SizedBox(width: 24),
                  Flexible(
                      fit: FlexFit.loose,
                      child: TextField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          hintText: 'Message Krofile...',
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF18C554),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/images/send.svg",
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 100, top: 24),
            child: SizedBox(
              height: 200,
              child: Row(
                children: [
                  IconButton(
                      onPressed: (activeIndex == 0)
                          ? null
                          : () {
                              _pageViewController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                      icon: const Icon(Icons.arrow_back_ios)),
                  Flexible(
                    child: PageView(
                      controller: _pageViewController,
                      children: [
                        Center(
                          child: Wrap(spacing: 10, runSpacing: 10, children: [
                            for (int index = 0; index < 8; index++)
                              ElevatedButton(
                                onPressed: () {
                                  selectCategory(
                                      exploreQuestion[index]['category'],
                                      index);
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: (activeIndex == index)
                                      ? const Color(0xFF18C554)
                                      : const Color(0xFFFFFFFF),
                                  foregroundColor: (activeIndex == index)
                                      ? const Color(0xFFFFFFFF)
                                      : const Color(0xFF73767B),
                                  padding: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    side: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                child: Text(
                                  exploreQuestion[index]['category'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ]),
                        ),
                        Center(
                          child: Wrap(spacing: 10, runSpacing: 10, children: [
                            for (int index = 9; index < 16; index++)
                              ElevatedButton(
                                onPressed: () {
                                  selectCategory(
                                      exploreQuestion[index]['category'],
                                      index);
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: (activeIndex == index)
                                      ? const Color(0xFF18C554)
                                      : const Color(0xFFFFFFFF),
                                  foregroundColor: (activeIndex == index)
                                      ? const Color(0xFFFFFFFF)
                                      : const Color(0xFF73767B),
                                  padding: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    side: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                child: Text(
                                  exploreQuestion[index]['category'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                          ]),
                        ),
                        Center(
                          child: Wrap(spacing: 10, runSpacing: 10, children: [
                            //  List.generate(
                            //   8,
                            //   (index) =>
                            for (int index = 9; index < 16; index++)
                              ElevatedButton(
                                onPressed: () {
                                  selectCategory(
                                      exploreQuestion[index]['category'],
                                      index);
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: (activeIndex == index)
                                      ? const Color(0xFF18C554)
                                      : const Color(0xFFFFFFFF),
                                  foregroundColor: (activeIndex == index)
                                      ? const Color(0xFFFFFFFF)
                                      : const Color(0xFF73767B),
                                  padding: const EdgeInsets.all(20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    side: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                child: Text(
                                  exploreQuestion[index]['category'],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            // ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: (activeIndex == 2)
                          ? null
                          : () {
                              _pageViewController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                      icon: const Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 100, right: 100),
              child: ListView.builder(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: selectedQuestions.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFE5E5E5), width: 1))),
                    child: ListTile(
                        title: Text(selectedQuestions[index]),
                        trailing:
                            BlocBuilder<ResponsepageCubit, ResponsepageState>(
                          builder: (context, state) {
                            return IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                              onPressed: () {
                                context
                                    .read<ResponsepageCubit>()
                                    .toggleQuestionFromFAQ(
                                        selectedQuestions[index]);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomePage()));
                              },
                            );
                          },
                        )),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
    // );
  }
}
