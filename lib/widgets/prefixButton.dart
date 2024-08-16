import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/services/faq_services.dart';
import 'package:krofile_ai/widgets/viewfaq_alert.dart';
import 'package:popover/popover.dart';

class PrefixButton extends StatefulWidget {
  const PrefixButton({
    super.key,
  });

  @override
  State<PrefixButton> createState() => _PrefixButtonState();
}

class _PrefixButtonState extends State<PrefixButton> {
  Future<void> _viewFaq() {
    return showDialog(
        barrierColor: const Color(0xFF000000).withOpacity(0.8),
        context: context,
        builder: (BuildContext context) {
          return const ViewFAQ();
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessResponseBloc, BusinessResponseState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: SvgPicture.asset("assets/images/arrow-up.svg"),
            onPressed: () {
              if (state.faq.isNotEmpty &&
                  state.faq.last != 'No Question Found!!!') {
                _viewFaq();
              } else {
                showPopover(
                  context: context,
                  barrierColor: Colors.transparent,
                  direction: PopoverDirection.top,
                  bodyBuilder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      width: 450,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Row(
                                children: [
                                  Icon(
                                    Icons.info,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    "Instructions",
                                    style: TextStyle(
                                      fontSize: 24,
                                      color: Color(0xFF151515),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "To our FAQ section! To add a question, click on the plus icon (+) next to existing questions. You can add up to 10 questions. Need to find the FAQ? Click the plus icon (+) on the search field. Questions? Reach out to us. Happy FAQ-ing!",
                          )
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
