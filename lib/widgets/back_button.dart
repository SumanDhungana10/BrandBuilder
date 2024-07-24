import 'package:flutter/material.dart';
import 'package:krofile_ai/screen/home_page.dart';

class OneBackButton extends StatelessWidget {
  const OneBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      },
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_back_ios_new_sharp,
            size: 16,
            color: Color(0xFF73767B),
          ),
          SizedBox(width: 10),
          Text(
            "Back",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF73767B)),
          ),
        ],
      ),
    );
  }
}
