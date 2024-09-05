import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:krofile_ai/bloc/customizescreen/customizescreen_bloc.dart';
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
    context.read<CustomizeScreenBloc>().add(FetchStarterConversations());
    final state = context.read<CustomizeScreenBloc>().state;
    final starterConversations = state.starterConversation;

    for (var i = 0; i < starterConversations.length; i++) {
      final controller =
          TextEditingController(text: starterConversations[i].question);
      _conversationStarterControllers.add(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CustomizeScreenBloc, CustomizeScreenState>(
        bloc: context.read<CustomizeScreenBloc>(),
        listenWhen: (previous, current) =>
            previous.fileUploadStatus != current.fileUploadStatus ||
            previous.conversationUpdateStatus !=
                current.conversationUpdateStatus,
        listener: (context, state) {
          if (state.conversationUpdateStatus ==
              ConversationUpdateStatus.updated) {
            context
                .read<CustomizeScreenBloc>()
                .add(ResetUpdateConversationStatus());
            context.pop();
          }
          if (state.fileUploadStatus == CustomizeFileUploadStatus.uploaded) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(milliseconds: 2000),
                content: Text('File uploaded successfully!')));
            context.read<CustomizeScreenBloc>().add(ResetGeneralFileUploaded());
          } else if (state.fileUploadStatus ==
              CustomizeFileUploadStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 500),
                content:
                    Text('File upload failed: ${state.fileuploadedresponse}')));
          }
        },
        builder: (context, state) {
          return Padding(
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
                        const Text("Customize",
                            style: TextStyle(
                                fontSize: 30,
                                color: Color(0xFF15141A),
                                fontWeight: FontWeight.w500)),
                        ElevatedButton(
                          onPressed: isSaveButtonEnabled
                              ? () {
                                  context
                                      .read<CustomizeScreenBloc>()
                                      .add(SaveStarterConversations());
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor:
                                const Color(0xFF1E7BC8).withOpacity(0.5),
                            backgroundColor: const Color(0xFF1E7BC8),
                            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: (state.conversationUpdateStatus ==
                                  ConversationUpdateStatus.updating)
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
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
                  const Text("Conversation Starters",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF151515),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state
                        .starterConversation.length, // Fixed to 8 controllers
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
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          surfaceTintColor:
                                              const Color(0xFFFAFAFA),
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          contentPadding: const EdgeInsets.only(
                                            left: 56,
                                            right: 32,
                                            bottom: 32,
                                          ),
                                          title: const Row(
                                            children: [
                                              Icon(
                                                Icons.help_outline_rounded,
                                              ),
                                              SizedBox(width: 10),
                                              Text("Confirm",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0xFF151515),
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text(
                                                "Are you sure you want to remove the question?\nThis action cannot be undone.",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color(0xFF151515),
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              const SizedBox(height: 14),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 44,
                                                      child: TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    30,
                                                                    10,
                                                                    30,
                                                                    10),
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFFCCCCCC),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Cancel",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Color(
                                                                      0xFF151515),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 24,
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      height: 44,
                                                      child: TextButton(
                                                          style: TextButton
                                                              .styleFrom(
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(0,
                                                                    10, 0, 10),
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFF1E7BC8),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          onPressed: () {
                                                            context
                                                                .read<
                                                                    CustomizeScreenBloc>()
                                                                .add(DeleteStarterConversation(state
                                                                    .starterConversation[
                                                                        index]
                                                                    .id));
                                                            _conversationStarterControllers
                                                                .removeAt(
                                                                    index);
                                                            setState(() {
                                                              isSaveButtonEnabled =
                                                                  true;
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Continue",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Color(
                                                                      0xFFFFFFFF),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400))),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Color(0xFF73767B),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              context.read<CustomizeScreenBloc>().add(
                                  UpdateStarterConversations(index, value));
                              setState(() {
                                isSaveButtonEnabled = value.isNotEmpty;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8 - state.starterConversation.length,
                    itemBuilder: (context, index) {
                      _conversationStarterControllers
                          .add(TextEditingController());
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
                            controller: _conversationStarterControllers[
                                state.starterConversation.length + index],
                            maxLength: 150,
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                              hintStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF73767B),
                              ),
                              // suffixIcon: IconButton(
                              //   onPressed: () {
                              //     context.read<CustomizeScreenBloc>().add(
                              //         DeleteStarterConversation(
                              //             state.starterConversation[index].id));

                              //     // Remove this text field's controller
                              //     _conversationStarterControllers
                              //         .removeAt(index);

                              //     // Add an empty text field in the second list
                              //     setState(() {
                              //       isSaveButtonEnabled = true;
                              //       _conversationStarterControllers
                              //           .add(TextEditingController());
                              //     });
                              //   },
                              //   icon: const Icon(
                              //     Icons.close,
                              //     color: Color(0xFF73767B),
                              //   ),
                              // ),
                            ),
                            onChanged: (value) {
                              context.read<CustomizeScreenBloc>().add(
                                    UpdateStarterConversations(index, value),
                                  );
                              setState(() {
                                isSaveButtonEnabled = value.isNotEmpty;
                              });
                            },
                          ),
                        ),
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
                      onPressed: () async {
                        await uploadedFile();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        side: const BorderSide(
                            color: Color(0xFFD4D4D4), width: 1),
                        backgroundColor: const Color(0xFFFAFAFA),
                        padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: (state.fileUploadStatus ==
                              CustomizeFileUploadStatus.notStarted)
                          ? const Text(
                              "Select file",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF151515)),
                            )
                          : const Text(
                              "Uploading...",
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
                        const Text(
                            "Use your chat data to make our models better:",
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
                            activeColor: const Color(0xFF1E7BC8),
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
          );
        },
      ),
    );
  }

  Future<void> uploadedFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'ppt',
        'pptx',
        'txt'
      ],
    );

    if (result != null && result.files.isNotEmpty) {
      if (mounted) {
        context
            .read<CustomizeScreenBloc>()
            .add(UploadGeneralFile(result.files.first));
      }
    }
  }
}
