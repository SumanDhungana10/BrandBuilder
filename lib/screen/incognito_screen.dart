import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/bloc/incognitoresponse/incognitoresponse_bloc.dart';
import 'package:krofile_ai/helper.dart';
import 'package:krofile_ai/utils/skeleton.dart';
import 'package:krofile_ai/utils/text_parse.dart';
import 'package:krofile_ai/utils/typewriter_text.dart';
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
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

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
                  Image.asset("assets/images/SquareLogo.png",
                      width: 50, height: 50),
                  const SizedBox(width: 10),
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
                  // IncognitoFileServices().deleteIncognitoFile();
                  // IncognitoFileServices().deleteallIncognitoHistory();
                
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
      body: BlocConsumer<IncognitoResponseBloc, IncognitoResponseState>(
        bloc: context.read<IncognitoResponseBloc>(),
        listenWhen: (previous, current) =>
            previous.fileUploadStatus != current.fileUploadStatus,
        listener: (context, state) {
          if (state.fileUploadStatus == FileUploadStatus.uploaded) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(milliseconds: 2000),
                content: Text('File uploaded successfully!')));
            context.read<IncognitoResponseBloc>().add(ResetFileUploaded());
          } else if (state.fileUploadStatus == FileUploadStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 500),
                content:
                    Text('File upload failed: ${state.fileuploadedresponse}')));
          }
        },
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
                            final questionanswer =
                                state.questionAnswerList[updateIndex];
                            final question = questionanswer.question;
                            final answer = questionanswer.answer;
                            final isRegenerating =
                                state.regeneratingIndices[updateIndex] ?? false;

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
                                            if (questionanswer.isLoading ||
                                                isRegenerating)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: List.generate(
                                                  3,
                                                  (index) => const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 10),
                                                    child: Skeletal(
                                                      height: 16,
                                                      width: double.infinity,
                                                      isIncognito: true,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            else if (questionanswer
                                                    .isNewResponse ||
                                                !questionanswer
                                                    .isAnimationCompleted)
                                              CustomAnimatedText(
                                                key: ValueKey(answer),
                                                text: answer,
                                                fontSize: 16,
                                                textColor: darktheme
                                                    .colorScheme.secondary,
                                                index: updateIndex,
                                                animationContext:
                                                    AnimationContext
                                                        .incognitoChat,
                                              )
                                            else
                                              RichText(
                                                text: TextSpan(
                                                  children: convertToBoldText(
                                                      answer,
                                                      fontSize: 16,
                                                      color: darktheme
                                                          .colorScheme.primary),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: darktheme
                                                        .colorScheme.primary,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            const SizedBox(height: 10),
                                            if (questionanswer
                                                .isAnimationCompleted)
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        tooltip: "Regenerate",
                                                        onPressed:
                                                            questionanswer
                                                                    .isLoading
                                                                ? null
                                                                : () {
                                                                    context
                                                                        .read<
                                                                            IncognitoResponseBloc>()
                                                                        .add(RegenerateIncognitoAnswer(
                                                                            updateIndex));
                                                                  },
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
                                                            ScaffoldMessenger
                                                                    .of(context)
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
                                                            Icons
                                                                .thumb_down_alt,
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
      bottomNavigationBar:
          BlocBuilder<IncognitoResponseBloc, IncognitoResponseState>(
        builder: (context, state) {
          return Padding(
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
                  child: TextFormField(
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
                          child: (state.fileUploadStatus ==
                                  FileUploadStatus.notStarted)
                              ? IconButton(
                                  icon: Icon(
                                    Icons.attach_file,
                                    color: darktheme.colorScheme.primary,
                                  ),
                                  onPressed: () async {
                                    await uploadedFile();
                                  },
                                )
                              : CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    darktheme.colorScheme.secondary,
                                  ),
                                ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFF1E7BC8),
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
                                      .add(HandleIncognitoQuestionType());
                                  context
                                      .read<IncognitoResponseBloc>()
                                      .add(AddIncognitoQuestionAnswerList(
                                        question: _inputQuestion.text,
                                      ));
                                  _inputQuestion.clear();
                                  FocusScope.of(context)
                                      .requestFocus(_textFocusNode);
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
                              .add(HandleIncognitoQuestionType());
                          context
                              .read<IncognitoResponseBloc>()
                              .add(AddIncognitoQuestionAnswerList(
                                question: _inputQuestion.text,
                              ));
                          _inputQuestion.clear();
                          FocusScope.of(context).requestFocus(_textFocusNode);
                        }
                      }),
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
            .read<IncognitoResponseBloc>()
            .add(UploadFile(result.files.first));
      }
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
