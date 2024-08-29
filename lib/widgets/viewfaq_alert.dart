import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';

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
      surfaceTintColor: const Color(0xFFFAFAFA),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Frequently Asked Questions",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF151515),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SizedBox(
        width: 600,
        height: 500,
        child: BlocBuilder<BusinessResponseBloc, BusinessResponseState>(
          builder: (context, state) {
            final faq = state.faq;

            // Check if faq contains "No Question Found!!!" and close the dialog
            // if (faq.contains("No Question Found!!!")) {
            //   WidgetsBinding.instance.addPostFrameCallback((_) {
            //     Navigator.of(context).pop();
            //   });
            //   return Container(); // Return an empty container while closing
            // }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 10),
                    itemCount: faq.length,
                    itemBuilder: (context, index) {
                      final faqItem = faq[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ListTile(
                          onTap: () {
                            context
                                .read<BusinessResponseBloc>()
                                .add(ToggleQuestionFromFAQ(faqItem));
                            Navigator.of(context).pop();
                          },
                          title: Text(
                            faqItem,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF151515),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              context
                                  .read<BusinessResponseBloc>()
                                  .add(RemoveFaq(faqItem));
                            },
                            icon: const Icon(Icons.close),
                          ),
                          shape: const Border(
                            bottom:
                                BorderSide(color: Color(0xFFd4d4d4), width: 1),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (state.faq.length < 5)
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: const Color(0xFF96D2AB),
                      backgroundColor: const Color(0xFF1E7BC8),
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "Add more",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
