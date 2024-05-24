import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';

class ViewMoreFeedBack extends StatefulWidget {
  const ViewMoreFeedBack({
    super.key,
  });

  @override
  State<ViewMoreFeedBack> createState() => _ViewMoreFeedBackState();
}

class _ViewMoreFeedBackState extends State<ViewMoreFeedBack> {
  final List<String> feedbackOptions = [
    "Doesn't seem correct",
    "Wasn't useful to me",
    "This is inappropriate or upsetting",
    "Prefer a different approach",
    "Had trouble with my file",
    "Missed some of my directions",
    "Should have responded differently",
    "Seems incomplete or lacking effort",
    "Something else",
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Container(
        padding: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFD4D4D4), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Provide additional feedback",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF151515)),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
      content: BlocBuilder<ResponsepageCubit, ResponsepageState>(
        builder: (context, state) {
          return SizedBox(
            width: 800,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Wrap(
                  spacing: 10,
                  runSpacing: 20,
                  children: [
                    for (int i = 0; i < feedbackOptions.length; i++)
                      ElevatedButton(
                          onPressed: () {
                           
                          },
                          style: ElevatedButton.styleFrom(
                            textStyle: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF151515),
                                fontWeight: FontWeight.w400),
                            padding: const EdgeInsets.all(24),
                            foregroundColor: const Color(0xFF151515),
                            // backgroundColor: Colors.white
                            side: const BorderSide(
                                color: Color(0xFFD4D4D4), width: 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Text(
                            feedbackOptions[i],
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF151515),
                                fontWeight: FontWeight.w400),
                          )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "(Optional) Feel free to add specific details",
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
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF18C554),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text("Submit")),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
