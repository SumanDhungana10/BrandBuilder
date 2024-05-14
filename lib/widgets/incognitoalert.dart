import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';

class IncognitoAlert extends StatefulWidget {
  const IncognitoAlert({
    super.key,
  });

  @override
  State<IncognitoAlert> createState() => _IncognitoAlertState();
}

class _IncognitoAlertState extends State<IncognitoAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: const EdgeInsets.all(30),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        content: SizedBox(
          width: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Welcome to Krofile Incognito Mode!",
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF15141A),
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 32,
              ),
              SvgPicture.asset(
                "assets/images/welcome-asset.svg",
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                textAlign: TextAlign.center,
                "Incognito Mode ensures enhanced privacy, safer communication, and avoids biased responses by not accessing previous conversations or user data, giving users control over sharing personal details and enabling uninterrupted, natural conversations without history tracking.",
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF15141A),
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  padding: const EdgeInsets.fromLTRB(100, 20, 100, 20),
                  foregroundColor: const Color(0xFFFFFFFF),
                  backgroundColor: const Color(0xFF18C554),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Continue in Incognito Mode"),
              ),
            ],
          ),
        ));
  }
}
