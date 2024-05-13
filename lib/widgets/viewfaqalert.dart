import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';

class ViewFAQ extends StatefulWidget {
  const ViewFAQ({
    super.key,
  });

  @override
  State<ViewFAQ> createState() => _ViewFAQState();
}

class _ViewFAQState extends State<ViewFAQ> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: BlocBuilder<ResponsepageCubit, ResponsepageState>(
        builder: (context, state) {
          return SizedBox(
            width: 600,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text(
                    "Frequently Asked Questions",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF151515)),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),
                for (var faqItem in state.faq)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListTile(
                      onTap: () {
                        context
                            .read<ResponsepageCubit>()
                            .toggleQuestionFromFAQ(faqItem);
                      
                        Navigator.of(context).pop();
                      },
                      title: Text(
                        faqItem,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF151515)),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<ResponsepageCubit>().removeFaq(faqItem);
                        },
                        icon: const Icon(Icons.close),
                      ),
                      shape: const Border(
                          bottom:
                              BorderSide(color: Color(0xFFd4d4d4), width: 1)),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
