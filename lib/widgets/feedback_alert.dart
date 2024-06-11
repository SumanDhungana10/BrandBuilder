import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedBackAlert extends StatefulWidget {
  const FeedBackAlert({super.key});

  @override
  State<FeedBackAlert> createState() => _FeedBackAlertState();
}

class _FeedBackAlertState extends State<FeedBackAlert> {
  double _currentReplayRating = 0;
  double _currentUserExperienceRating = 0;
  double _currentOverallSatisfactionRating = 0;
  final TextEditingController _additionalNotesController =
      TextEditingController();
  bool _isSubmitButtonEnabled = false;

  Color getColorForRating(double rating, int index) {
    if (index < rating) {
      if (rating <= 1) {
        return const Color(0xFFFF5733);
      } else if (rating <= 2) {
        return const Color(0xFFFFC300);
      } else if (rating <= 3) {
        return const Color(0xFFF4D03F);
      } else if (rating <= 4) {
        return const Color(0xFF4CAF50);
      } else {
        return const Color(0xFF2ECC71);
      }
    } else {
      return const Color(0xFF484848);
    }
  }

  @override
  void initState() {
    super.initState();
    _additionalNotesController.addListener(_checkSubmitButtonState);
  }

  void _checkSubmitButtonState() {
    setState(() {
      _isSubmitButtonEnabled = _additionalNotesController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _additionalNotesController.removeListener(_checkSubmitButtonState);
    _additionalNotesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      contentPadding: const EdgeInsets.all(24),
      content: SizedBox(
        width: 700,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "AI Feedback Hub",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF151515)),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Share Your Experience. Let us know how our AI is doing! Your feedback helps us improve our services and provide a better experience for you and others. Rate our AI and leave any comments or suggestions below.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              const Divider(
                color: Color(0xFFD4D4D4),
                thickness: 1,
              ),
              const SizedBox(height: 16),
              const Text(
                "Rate our Replies",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF151515),
                ),
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: 0,
                direction: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Icon(
                    index < _currentReplayRating
                        ? Icons.circle
                        : Icons.circle_outlined,
                    color: getColorForRating(_currentReplayRating, index),
                  );
                },
                itemSize: 32,
                itemPadding: const EdgeInsets.only(right: 64),
                onRatingUpdate: (rating) {
                  setState(() {
                    _currentReplayRating = rating;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text(
                "Rate User Experience",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF151515),
                ),
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: 0,
                direction: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Icon(
                    index < _currentUserExperienceRating
                        ? Icons.circle
                        : Icons.circle_outlined,
                    color:
                        getColorForRating(_currentUserExperienceRating, index),
                  );
                },
                itemSize: 32,
                itemPadding: const EdgeInsets.only(right: 64),
                onRatingUpdate: (rating) {
                  setState(() {
                    _currentUserExperienceRating = rating;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text(
                "Rate Overall Satisfaction",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF151515),
                ),
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: 0,
                direction: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Icon(
                    index < _currentOverallSatisfactionRating
                        ? Icons.circle
                        : Icons.circle_outlined,
                    color: getColorForRating(
                        _currentOverallSatisfactionRating, index),
                  );
                },
                itemSize: 32,
                itemPadding: const EdgeInsets.only(right: 64),
                onRatingUpdate: (rating) {
                  setState(() {
                    _currentOverallSatisfactionRating = rating;
                  });
                },
              ),
              const SizedBox(height: 24),
              const Text(
                "Additional Notes",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF151515),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD4D4D4)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  maxLines: 3,
                  maxLength: 200,
                  controller: _additionalNotesController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: InputBorder.none,
                    hintText:
                        "Tell us about your experience with Krofile AI. Your feedback helps us improve!",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF73767B),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF151515)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _isSubmitButtonEnabled
                        ? () {
                            // Handle submit action
                            Navigator.of(context).pop();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: const Color(0xFF96D2AB),
                      backgroundColor: const Color(0xFF18C554),
                      padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
