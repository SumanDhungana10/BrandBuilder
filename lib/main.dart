import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/app_router.dart';
import 'package:krofile_ai/bloc/explore/explore_bloc.dart';
import 'package:krofile_ai/bloc/incognitoresponse/incognitoresponse_bloc.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/bloc/mylist/mylist_bloc.dart';
import 'package:krofile_ai/bloc/customizescreen/customizescreen_bloc.dart';
import 'package:krofile_ai/bloc/homescreen/homescreen_bloc.dart';

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
          create: (context) {
            final bloc = BusinessResponseBloc();
            bloc.add(GetFaq());
            bloc.add(FetchHistory());

            return bloc;
          },
        ),
        BlocProvider<MylistBloc>(
          create: (context) {
            final bloc = MylistBloc();
            bloc.add(FetchMylist());
            return bloc;
          },
        ),
        BlocProvider<CustomizeScreenBloc>(
          create: (context) {
            final bloc = CustomizeScreenBloc();
            bloc.add(FetchStarterConversations());
            return bloc;
          }
        ),
        BlocProvider<IncognitoResponseBloc>(
          create: (context) => IncognitoResponseBloc(),
        ),
        BlocProvider<ExploreBloc>(create: (context) => ExploreBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Krofile AI',
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFFFFFFF)),
        routerConfig: router,
      ),
    );
  }
}
