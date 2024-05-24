import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';
import 'package:krofile_ai/cubit/threedot/threedot_cubit.dart';
import 'package:krofile_ai/screen/homepage.dart';
import 'package:krofile_ai/widgets/incognitoalert.dart';

class IncognitoMode extends StatefulWidget {
  const IncognitoMode({super.key});

  @override
  State<IncognitoMode> createState() => _IncognitoModeState();
}

class _IncognitoModeState extends State<IncognitoMode> {
  final TextEditingController _inputQuestion = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _textFocusNode.dispose();
    _inputQuestion.dispose();
  }

  List<String> initialView = [
    'Generate strategies to effectively scale my social media marketing efforts.',
    'How brands can effectively leverage online advertising?',
    'Generate top five content ideas for my business',
    'Give me 5 subject lines for my email marketing campaign.'
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _incognitoAlert(context);
    });
  }

  Future<void> _incognitoAlert(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        barrierColor: const Color(0xFF000000).withOpacity(0.8),
        context: context,
        builder: (BuildContext context) {
          return const IncognitoAlert();
        });
  }

  FilePickerResult? result;
  PlatformFile? pickedFile;
  Uint8List? pickedFileBytes;
  bool _isHovering = false;
  bool _isQuestion = false;
  List<String> answerList = [
    'Generate strategies to effectively scale my social media marketing efforts.',
    'Generate top five content ideas for my business',
    'Give me 5 subject lines for my email marketing campaign.'
  ];
  List<Map<String, dynamic>> questionAnswerList = [];

  void handelQuestionType(String question) {
    setState(() {
      _isQuestion = true;
      questionAnswerList.add({
        'image': pickedFileBytes,
        'question': question,
        'answer': answerList[questionAnswerList.length % answerList.length],
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darktheme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: darktheme.colorScheme.background,
        scrolledUnderElevation: 0,
        shape: const Border(
          bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
        ),
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset("assets/images/SquareLogo.png",
                      width: 50, height: 50),
                  Text("Krofile AI",
                      style: TextStyle(
                          fontSize: 24,
                          color: darktheme.colorScheme.primary,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              BlocBuilder<ThreedotCubit, ThreedotState>(
                builder: (context, state) {
                  return ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  contentPadding: const EdgeInsets.all(24),
                                  title: const Row(
                                    children: [
                                      Icon(
                                        Icons.error,
                                        color: Color(0xFFFF8C22),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "Click continue to exit incognito mode.",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF151515),
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 10, 30, 10),
                                          backgroundColor:
                                              const Color(0xFFCCCCCC),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFF151515),
                                                fontWeight: FontWeight.w400))),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 10, 30, 10),
                                          backgroundColor:
                                              const Color(0xFF21201F),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const HomePage()));
                                        },
                                        child: const Text("Continue",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xFFFFFFFF),
                                                fontWeight: FontWeight.w400)))
                                  ],
                                ));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        textStyle: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                        foregroundColor: darktheme.colorScheme.primary,
                        backgroundColor: darktheme.colorScheme.background,
                        side: const BorderSide(
                            color: Color(0xFFE5E5E5), width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      label: const Text("Exit Incognito"),
                      icon: Icon(
                        Icons.exit_to_app,
                        color: darktheme.colorScheme.primary,
                      ));
                },
              )
            ],
          ),
        ),
      ),
      body: (_isQuestion == false)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/images/SquareLogo.png",
                  height: 80,
                  width: 80,
                ),
                Text("How can I help you today?",
                    style: TextStyle(
                        fontSize: 30,
                        color: darktheme.colorScheme.secondary,
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
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _isQuestion = true;
                            });
                            handelQuestionType(initialView[index]);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: const Color(0xFFE5E5E5)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              initialView[index],
                              style: TextStyle(
                                fontSize: 16,
                                color: darktheme.colorScheme.primary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                        //   }
                        // );
                      }),
                ),
              ],
            )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: questionAnswerList.length,
                        itemBuilder: (context, index) {
                          final updateIndex =
                              questionAnswerList.length - index - 1;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                                      child: Column(
                                        children: [
                                          Text(
                                            questionAnswerList[updateIndex]
                                                ['question']!,
                                            // widget.questionAnswerList[updateIndex]
                                            //     ['question'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  darktheme.colorScheme.primary,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        color: Color(0xFFE5E5E5), width: 1),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            questionAnswerList[index]
                                                ['answer']!,
                                            // widget.questionAnswerList[index]
                                            //     ['answer'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              color:
                                                  darktheme.colorScheme.primary,
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
                                                      onPressed: () {
                                                        // context.read()<ResponsepageCubit>().regenerateAnswer(
                                                        //     widget.index,
                                                        //     state.questionAnswerList[widget.index]
                                                        //         ['question']);
                                                      },
                                                      icon: Icon(
                                                        Icons.repeat,
                                                        size: 24,
                                                        color: darktheme
                                                            .colorScheme
                                                            .primary,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.share_outlined,
                                                        size: 24,
                                                        color: darktheme
                                                            .colorScheme
                                                            .primary,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons
                                                            .file_copy_outlined,
                                                        size: 24,
                                                        color: darktheme
                                                            .colorScheme
                                                            .primary,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons
                                                            .bookmark_border_outlined,
                                                        size: 24,
                                                        color: darktheme
                                                            .colorScheme
                                                            .primary,
                                                      ))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons
                                                            .thumb_up_alt_outlined,
                                                        size: 24,
                                                        color: darktheme
                                                            .colorScheme
                                                            .primary,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {
                                                        // context
                                                        //     .read<
                                                        //         DislikefeedbackCubit>()
                                                        //     .disLikeFeedback(index);
                                                        // setState(() {
                                                        //   isfeedbackopen = !isfeedbackopen;
                                                        // });
                                                      },
                                                      icon: Icon(
                                                        Icons
                                                            .thumb_down_alt_outlined,
                                                        size: 24,
                                                        color: darktheme
                                                            .colorScheme
                                                            .primary,
                                                      )),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE5E5E5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (result != null)
                    Stack(
                      children: [
                        MouseRegion(
                          onEnter: (event) => setState(() {
                            _isHovering = true;
                          }),
                          onHover: (event) => setState(() {
                            _isHovering = true;
                          }),
                          onExit: (event) => setState(() {
                            _isHovering = false;
                          }),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(
                              pickedFileBytes!,
                              fit: BoxFit.cover,
                              width: 60,
                              height: 60,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: MouseRegion(
                            onEnter: (event) => setState(() {
                              _isHovering = true;
                            }),
                            onHover: (event) => setState(() {
                              _isHovering = true;
                            }),
                            onExit: (event) => setState(() {
                              _isHovering = false;
                            }),
                            child: _isHovering
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        result = null;
                                      });
                                    },
                                    child: CircleAvatar(
                                      radius: 12,
                                      backgroundColor:
                                          darktheme.colorScheme.background,
                                      child: Icon(
                                        Icons.close_sharp,
                                        color: darktheme.colorScheme.primary,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                      ],
                    ),
                  TextFormField(
                    controller: _inputQuestion,
                    focusNode: _textFocusNode,
                    style: TextStyle(
                      fontSize: 16,
                      color: darktheme.colorScheme.primary,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.attach_file,
                            color: darktheme.colorScheme.primary,
                          ),
                          onPressed: () async {
                            await uploadedFile();
                          },
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
                            onPressed: () {
                              if (_inputQuestion.text.isNotEmpty) {
                                setState(() {
                                  _isQuestion = true;
                                });
                                _inputQuestion.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      hintText: 'Message Krofile...',
                      hintStyle: TextStyle(
                        fontSize: 16,
                        color: darktheme.colorScheme.primary,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: darktheme.colorScheme.background,
                    ),
                    onFieldSubmitted: (value) {
                      if (_inputQuestion.text.isNotEmpty) {
                        setState(() {
                          _isQuestion = true;
                        });
                        handelQuestionType(_inputQuestion.text);
                        _inputQuestion.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Double-check important information as GPT can make mistakes.",
              style: TextStyle(
                fontSize: 14,
                color: darktheme.colorScheme.primary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uploadedFile() async {
    result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null && result!.files.isNotEmpty) {
      setState(() {
        pickedFile = result!.files.first;
        pickedFileBytes = pickedFile!.bytes;
      });
    }
  }
}

ThemeData darktheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    background: Color(0xFF272727),
    primary: Color(0xFFFAFAFA),
    secondary: Color(0xFFFFFFFF),
  ),
);
