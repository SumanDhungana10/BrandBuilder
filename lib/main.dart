import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/app_router.dart';
import 'package:krofile_ai/bloc/bloc/incognitoresponse_bloc.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/bloc/explorescreen/explorescreen_bloc.dart';
import 'package:krofile_ai/bloc/mylist/mylist_bloc.dart';
import 'package:krofile_ai/bloc/customizescreen/customizescreen_bloc.dart';
import 'package:krofile_ai/bloc/homescreen/homescreen_bloc.dart';
import 'bloc/responsefeedback/responsefeedback_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeScreenBloc>(
          create: (context) => HomeScreenBloc(),
        ),
        BlocProvider<BusinessResponseBloc>(
          create: (context) => BusinessResponseBloc(),
        ),
        BlocProvider<ResponsefeedbackBloc>(
          create: (context) => ResponsefeedbackBloc(),
        ),
        BlocProvider<MylistBloc>(
          create: (context) => MylistBloc(),
        ),
        BlocProvider<CustomizeScreenBloc>(
          create: (context) => CustomizeScreenBloc(),
        ),
        BlocProvider<ExploreScreenBloc>(
          create: (context) => ExploreScreenBloc(),
        ),
        BlocProvider<IncognitoResponseBloc>(
          create: (context) => IncognitoResponseBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Krofile AI',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFAFAFA)),
        routerConfig: router,
      ),
    );
  }
}
