import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/bloc/bloc/incognitoresponse_bloc.dart';
import 'package:krofile_ai/utils/text_parse.dart';
import 'package:krofile_ai/widgets/incognito_alert.dart';
import 'package:krofile_ai/widgets/incognito_exit_alert.dart';

class IncognitoMode extends StatefulWidget {
  const IncognitoMode({super.key});

  @override
  State<IncognitoMode> createState() => _IncognitoModeState();
}

class _IncognitoModeState extends State<IncognitoMode> {
  final TextEditingController _inputQuestion = TextEditingController();
  final FocusNode _textFocusNode = FocusNode();
  FilePickerResult? result;
  PlatformFile? pickedFile;
  Uint8List? pickedFileBytes;
  bool isHoveringList = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _incognitoAlert(context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textFocusNode.dispose();
    _inputQuestion.dispose();
  }

  Future<void> _incognitoAlert(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      barrierColor: const Color(0xFF000000).withOpacity(0.8),
      context: context,
      builder: (BuildContext context) {
        return const IncognitoAlert();
      },
    );
  }

  Future<void> _incognitoExitAlert(BuildContext context) async {
    return showDialog(
      barrierDismissible: false,
      barrierColor: const Color(0xFF000000).withOpacity(0.8),
      context: context,
      builder: (BuildContext context) {
        return const IncognitoExitAlert();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darktheme.colorScheme.surface,
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        backgroundColor: darktheme.colorScheme.surface,
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
                  Image.asset("assets/images/logo.png", width: 50, height: 50),
                  Text("Krofile AI",
                      style: TextStyle(
                          fontSize: 24,
                          color: darktheme.colorScheme.primary,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _incognitoExitAlert(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  foregroundColor: darktheme.colorScheme.primary,
                  backgroundColor: darktheme.colorScheme.surface,
                  side: const BorderSide(color: Color(0xFFE5E5E5), width: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                label: const Text("Exit Incognito"),
                icon: Icon(
                  Icons.exit_to_app,
                  color: darktheme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocBuilder<IncognitoResponseBloc, IncognitoResponseState>(
        builder: (context, state) {
          final length = state.questionAnswerList.length;
          return (!state.isQuestionType)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/SquareLogo.png",
                        height: 80,
                        width: 80,
                      ),
                      Text("Temporary Chats",
                          style: TextStyle(
                              fontSize: 30,
                              color: darktheme.colorScheme.secondary,
                              fontWeight: FontWeight.w700)),
                      const SizedBox(
                        height: 48,
                      ),
                      Text(
                        "This chat won't be saved in your history, stored as a memory, or used to train our models. \n For safety reasons, we might retain a copy for up to 30 days.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: darktheme.colorScheme.secondary),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: state.questionAnswerList.length,
                          itemBuilder: (context, index) {
                            final updateIndex =
                                state.questionAnswerList.length - index - 1;
                            final files =
                                state.questionAnswerList[updateIndex].file;
                            final question =
                                state.questionAnswerList[updateIndex].question;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xFFE5E5E5),
                                            width: 1)),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (files != null)
                                              Row(
                                                children: [
                                                  if (files.extension ==
                                                          'jpg' ||
                                                      files.extension == 'png')
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: Image.memory(
                                                        files.bytes!,
                                                        height: 100,
                                                        width: 100,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  else
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10.0),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                                color: darktheme
                                                                    .colorScheme
                                                                    .surface,
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                border: Border.all(
                                                                    color: darktheme
                                                                        .colorScheme
                                                                        .secondary,
                                                                    width: 1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  10,
                                                                )),
                                                        child: Row(
                                                          children: [
                                                            Center(
                                                              child: Icon(
                                                                files.extension ==
                                                                        'pdf'
                                                                    ? Icons
                                                                        .picture_as_pdf
                                                                    : Icons
                                                                        .description,
                                                                color: Colors
                                                                    .white,
                                                                size: 50,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                width: 10),
                                                            Text(
                                                              files.name,
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: darktheme
                                                                      .colorScheme
                                                                      .primary),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            const SizedBox(
                                                height:
                                                    8), // Add some space between images and text
                                            Text(
                                              question,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: darktheme
                                                    .colorScheme.primary,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            (state
                                                        .questionAnswerList[
                                                            updateIndex]
                                                        .isLoading ==
                                                    true)
                                                ? const LinearProgressIndicator(
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Color(0xFF18C554)),
                                                  )
                                                // : Text(
                                                //     state
                                                //         .questionAnswerList[
                                                //             updateIndex]
                                                //         .answer,
                                                //     style: TextStyle(
                                                //       fontSize: 16,
                                                //       color: darktheme
                                                //           .colorScheme.primary,
                                                //       fontWeight:
                                                //           FontWeight.w400,
                                                //     ),
                                                //   ),
                                                : RichText(
                                                    text: TextSpan(
                                                      children:
                                                          convertToBoldText(state
                                                              .questionAnswerList[
                                                                  updateIndex]
                                                              .answer, fontSize: 16),
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: darktheme
                                                            .colorScheme
                                                            .primary,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      tooltip: "Regenerate",
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.replay_outlined,
                                                        size: 24,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      tooltip: "Share",
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.share_outlined,
                                                        size: 24,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      tooltip: "Copy",
                                                      onPressed: () {
                                                        Clipboard.setData(ClipboardData(
                                                                text: state
                                                                    .questionAnswerList[
                                                                        length -
                                                                            index -
                                                                            1]
                                                                    .answer))
                                                            .then((_) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(const SnackBar(
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          500),
                                                                  content: Text(
                                                                      'Copied to your clipboard!')));
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .file_copy_outlined,
                                                        size: 24,
                                                        color:
                                                            Color(0xFFFFFFFF),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      icon: const Icon(
                                                        Icons.thumb_up_alt,
                                                        color:
                                                            Color(0xFFFAFAFA),
                                                      ),
                                                      onPressed: () {},
                                                    ),
                                                    IconButton(
                                                      icon: const Icon(
                                                          Icons.thumb_down_alt,
                                                          color: Color(
                                                              0xFFFAFAFA)),
                                                      onPressed: () {},
                                                    )
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
                          },
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
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
                  if (pickedFile != null)
                    Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Stack(
                                clipBehavior: Clip
                                    .none, // Ensures the Positioned widget is not clipped
                                children: [
                                  MouseRegion(
                                    onEnter: (event) => setState(() {
                                      isHoveringList = true;
                                    }),
                                    onExit: (event) => setState(() {
                                      isHoveringList = false;
                                    }),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: (pickedFile?.extension == 'pdf')
                                          ? Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: darktheme
                                                    .colorScheme.surface,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: darktheme
                                                      .colorScheme.primary,
                                                  width: 1,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.picture_as_pdf,
                                                    size: 30,
                                                    color: darktheme
                                                        .colorScheme.primary,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    pickedFile!.name,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: darktheme
                                                          .colorScheme.primary,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : (pickedFile?.extension == 'doc' ||
                                                  pickedFile?.extension ==
                                                      'docx')
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                    color: darktheme
                                                        .colorScheme.surface,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      color: darktheme
                                                          .colorScheme.primary,
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.description,
                                                        size: 30,
                                                        color: darktheme
                                                            .colorScheme
                                                            .secondary,
                                                      ),
                                                      const SizedBox(width: 10),
                                                      Text(
                                                        pickedFile!.name,
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: darktheme
                                                              .colorScheme
                                                              .primary,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Image.memory(
                                                  pickedFileBytes!,
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                  ),
                                  Positioned(
                                    right:
                                        -10, // Move the icon slightly outside the image
                                    top:
                                        -5, // Move the icon slightly outside the image
                                    child: MouseRegion(
                                      onEnter: (event) => setState(() {
                                        isHoveringList = true;
                                      }),
                                      onExit: (event) => setState(() {
                                        isHoveringList = false;
                                      }),
                                      child: AnimatedOpacity(
                                        opacity: isHoveringList ? 1.0 : 0.0,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              pickedFile = null;
                                              pickedFileBytes = null;
                                              isHoveringList = false;
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: const Color(
                                                    0xFFFFFFFF), // Change color as needed
                                                width: 1, // Border width
                                              ),
                                            ),
                                            child: CircleAvatar(
                                              radius:
                                                  12, // Increase radius to make it larger
                                              backgroundColor:
                                                  darktheme.colorScheme.surface,
                                              child: Icon(
                                                Icons.close_sharp,
                                                color: darktheme
                                                    .colorScheme.primary,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
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
                                  context
                                      .read<IncognitoResponseBloc>()
                                      .add(HandleQuestionType());
                                  context
                                      .read<IncognitoResponseBloc>()
                                      .add(AddQuestionAnswerList(
                                        question: _inputQuestion.text,
                                        files: pickedFile,
                                      ));
                                  _inputQuestion.clear();
                                  setState(() {
                                    pickedFile = null;
                                    pickedFileBytes = null;
                                    isHoveringList = false;
                                  });
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
                        fillColor: darktheme.colorScheme.surface,
                      ),
                      onFieldSubmitted: (value) {
                        if (_inputQuestion.text.isNotEmpty) {
                          context
                              .read<IncognitoResponseBloc>()
                              .add(HandleQuestionType());
                          context
                              .read<IncognitoResponseBloc>()
                              .add(AddQuestionAnswerList(
                                question: _inputQuestion.text,
                                files: pickedFile,
                              ));
                          _inputQuestion.clear();
                          FocusScope.of(context).requestFocus(_textFocusNode);
                          setState(() {
                            pickedFile = null;
                            pickedFileBytes = null;
                            isHoveringList = false;
                          });
                        }
                      }),
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
    result = await FilePicker.platform.pickFiles(
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

    if (result != null && result!.files.isNotEmpty) {
      setState(() {
        for (int i = 0; i < result!.files.length; i++) {
          pickedFile = result!.files[i];
          pickedFileBytes = pickedFile!.bytes;
          isHoveringList = false;
        }
      });
    }
  }
}

ThemeData darktheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF272727),
    primary: Color(0xFFFAFAFA),
    secondary: Color(0xFFFFFFFF),
  ),
);
