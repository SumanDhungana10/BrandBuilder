import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/cubit/homepage/homepage_cubit.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';
// import 'package:krofile_ai/Screen/home_screen.dart';
import 'package:krofile_ai/screen/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomepageCubit>(
          create: (context) => HomepageCubit(),
        ),
        BlocProvider<ResponsepageCubit>(
          create: (context) => ResponsepageCubit(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Krofile AI',
        home: HomePage(),
      ),
    );
  }
}
