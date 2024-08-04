import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/bloc/customizescreen/customizescreen_bloc.dart';
import 'package:krofile_ai/screen/home_screen.dart';
import 'package:krofile_ai/widgets/back_button.dart';

class CustomizeScreen extends StatefulWidget {
  const CustomizeScreen({super.key});

  @override
  State<CustomizeScreen> createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  bool isSaveButtonEnabled = false;
  bool isReadonly = true;
  final TextEditingController _inputText = TextEditingController(
      text:
          'Always use knowledge document krofileknowledge.txt to align with business goals of "One Link" before generating output.');
  final FocusNode _textFocusNode = FocusNode();
  final List<TextEditingController> _conversationStarterControllers = [];

  bool isUseChatData = false;

  @override
  void dispose() {
    super.dispose();
    _textFocusNode.dispose();
    _inputText.dispose();
    for (var controller in _conversationStarterControllers) {
      controller.dispose();
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize controllers for the starter conversations
    final state = context.read<CustomizeScreenBloc>().state;
    for (var i = 0; i < 8; i++) {
      final controller = TextEditingController(
        text: i < state.starterConversation.length
            ? state.starterConversation[i]
            : '',
        // text: state.starterConversation[i],
      );
      _conversationStarterControllers.add(controller);
    }
  }

  void _saveConversations() {
    final updatedConversations = _conversationStarterControllers
        .map((controller) => controller.text)
        .toList();
    context
        .read<CustomizeScreenBloc>()
        .add(UpdateAllStarterConversations(updatedConversations));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OneBackButton(),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("My List",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF15141A),
                            fontWeight: FontWeight.w500)),
                    ElevatedButton(
                      onPressed: isSaveButtonEnabled
                          ? () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()));
                              _saveConversations();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: const Color(0xFF96D2AB),
                        backgroundColor: const Color(0xFF18C554),
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Color(0xFFE5E5E5),
                thickness: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text("Custom Instructions",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF151515),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAFA),
                    border: Border.all(
                      color: const Color(0xFFD4D4D4),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextFormField(
                    controller: _inputText,
                    maxLength: 250,
                    maxLines: 2,
                    readOnly: isReadonly,
                    focusNode: _textFocusNode,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF73767B),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        isSaveButtonEnabled = value.isNotEmpty;
                      });
                    },
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isReadonly = false;
                  });
                  FocusScope.of(context).requestFocus(_textFocusNode);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit,
                      size: 16,
                      color: Color(0xFF73767B),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Edit",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF73767B),
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text("Conversation Starters",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF151515),
                  )),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<CustomizeScreenBloc, CustomizeScreenState>(
                builder: (context, state) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAFAFA),
                            border: Border.all(
                              color: const Color(0xFFD4D4D4),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: TextFormField(
                            controller: _conversationStarterControllers[index],
                            maxLength: 150,
                            decoration: InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(10),
                              hintStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF73767B),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _conversationStarterControllers[index]
                                        .clear();
                                    isSaveButtonEnabled = true;
                                  });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Color(0xFF73767B),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                isSaveButtonEnabled = value.isNotEmpty;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Knowledge base",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF151515),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                    "If you upload files under knowledge, conversation with your GPT may include file contents. File can be downloaded when Code Interpreter is enabled.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF73767B),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    side: const BorderSide(color: Color(0xFFD4D4D4), width: 1),
                    backgroundColor: const Color(0xFFFAFAFA),
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Select file",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF151515)),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text("Quick Reply Controls",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF151515),
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                    "Adjust how suggested replies work in your chats. Enable or disable with ease.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF73767B),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    const Text("Use your chat data to make our models better:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF151515),
                        )),
                    Transform.scale(
                      scale:
                          0.75, // Adjust the scale factor to get the desired size
                      child: CupertinoSwitch(
                        value: isUseChatData,
                        thumbColor: const Color(0xFFFFFFFF),
                        activeColor: const Color(0xFF18C554),
                        trackColor: const Color(0xFF73767B),
                        onChanged: (value) {
                          setState(() {
                            isSaveButtonEnabled = true;

                            isUseChatData = value;
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
