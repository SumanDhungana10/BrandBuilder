import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  bool _isSidebarOpen = true;
  final TextEditingController _inputQuestion = TextEditingController();
  final List<String> _questionList = [];
  final List<String> _answerList = [
    'Generate strategies to effectively scale my social media marketing efforts.',
    'How brands can effectively leverage online advertising?',
    'Generate top five content ideas for my business',
    'Give me 5 subject lines for my email marketing campaign.'
  ];
  final List<Map<String, dynamic>> _questionAnswerList = [];
  void _handelquestion() {
    setState(() {
      _questionList.add(_inputQuestion.text);
      _questionAnswerList.add({
        'question': _inputQuestion.text,
        'answer': _answerList[0],
      });
      _inputQuestion.clear();
    });
  }

  void _toggleSidebar() {
    setState(() {
      _isSidebarOpen = !_isSidebarOpen;
    });
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
                PopupMenuButton(
                  color: Colors.white,
                  onSelected: (int result) {},
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                    const PopupMenuItem<int>(
                      value: 1,
                      child: ListTile(
                        title: Text('Official '),
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: ListTile(
                        title: Text('Popular'),
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 3,
                      child: ListTile(
                        title: Text('For You'),
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 4,
                      child: ListTile(
                        title: Text('Customer Acquisition'),
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 5,
                      child: ListTile(
                        title: Text('Customer Retention'),
                      ),
                    ),
                  ],
                ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    Image.asset(
                      "assets/images/logo.png",
                      height: 80,
                      width: 80,
                    ),
                    const Text("How can I help you today?",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF151515),
                            fontWeight: FontWeight.w700)),
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
                            return Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xFFE5E5E5)),
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
                            );
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Row(
                          children: [
                            Image.asset("assets/images/image32.png"),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                controller: _inputQuestion,
                                decoration: InputDecoration(
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
                                    child: IconButton(
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.purple[400],
                                        shape: const CircleBorder(
                                          side: BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      icon: SvgPicture.asset(
                                          "assets/images/send.svg"),
                                      onPressed: () {
                                        _handelquestion();
                                      },
                                    ),
                                  ),
                                  hintText: 'Message Krofile...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SvgPicture.asset("assets/images/apps.svg"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(right: _isSidebarOpen ? 300.0 : 0),
                child: IconButton(
                  icon: (_isSidebarOpen)
                      ? Image.asset("assets/images/Vectorright.png")
                      : Image.asset("assets/images/Vectorleft.png"),
                  onPressed: _toggleSidebar,
                ),
              ),
            ],
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: 0,
            bottom: 0,
            right: _isSidebarOpen ? 0 : -300,
            child: Container(
              width: 300,
              decoration: const BoxDecoration(
                color: Colors.amber,
                border: Border(
                  left: BorderSide(color: Color(0xFFE5E5E5), width: 1),
                ),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sidebar',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),

                  // Add your sidebar content here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
