import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/cubit/customizepage/customizepage_cubit.dart';
import 'package:krofile_ai/cubit/dislikefeedback/dislikefeedback_cubit.dart';
import 'package:krofile_ai/cubit/explore/explore_cubit.dart';
import 'package:krofile_ai/cubit/homepage/homepage_cubit.dart';
import 'package:krofile_ai/cubit/mylist/mylist_cubit.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';
import 'package:krofile_ai/cubit/homepage_popupmenu/homepage_popup_cubit.dart';
import 'package:krofile_ai/screen/home_page.dart';

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
        BlocProvider<DislikefeedbackCubit>(
          create: (context) => DislikefeedbackCubit(),
        ),
        BlocProvider<ThreedotCubit>(
          create: (context) => ThreedotCubit(),
        ),
        BlocProvider<MylistCubit>(
          create: (context) => MylistCubit(),
        ),
        BlocProvider<CustomizepageCubit>(
          create: (context) => CustomizepageCubit(),
        ),
        BlocProvider<ExploreCubit>(
          create: (context) => ExploreCubit(),
        ),
      ],
      child: BlocBuilder<ThreedotCubit, ThreedotState>(
        builder: (context, state) {
          // return (!state.isIncognitoMode)
          //     ? const MaterialApp(
          //         debugShowCheckedModeBanner: false,
          //         title: 'Krofile AI',
          //         home: HomePage(),
          //       )
          //     : const MaterialApp(
          //         debugShowCheckedModeBanner: false,
          //         title: 'Krofile AI',
          //         home: IncognitoMode(),
          //       );
          // return const MaterialApp(
          //   debugShowCheckedModeBanner: false,
          //   title: 'Krofile AI',
          //   home: HomePage(),
          // );
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Krofile AI',
            home: HomePage(),
          );
        },
      ),
    );
  }
}
