import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:krofile_ai/screen/home_page.dart';

class IncognitoExitAlert extends StatelessWidget {
  const IncognitoExitAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
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
                  fontWeight: FontWeight.w500)),
        ],
      ),
      content: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Are you sure you want to close the incognito mode? This action cannot be undone.",
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF151515),
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                          backgroundColor: const Color(0xFFCCCCCC),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF151515),
                                fontWeight: FontWeight.w400))),
                  ),
                ),
                const SizedBox(
                  width: 24,
                ),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          backgroundColor: const Color(0xFF21201F),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                        child: const Text("Continue",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w400))),
                  ),
                )
              ],
            )
          ],
        ),
      ),
     
    );
  }
}
