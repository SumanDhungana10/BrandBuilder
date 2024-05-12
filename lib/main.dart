import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/Screen/home_screen.dart';
// import 'package:krofile_ai/Screen/home_screen.dart';
import 'package:krofile_ai/screen/nexthomepage.dart';
import 'package:krofile_ai/screen/test.dart';
import 'package:krofile_ai/cubit/homepage_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Krofile AI',
      home: BlocProvider(
        create: (context) => HomepageCubit(),
        // child: const HomePage(),
        child: const NextHomePage(),
        // child: MyHomePage()
      ),
    );
  }
}
