import 'package:go_router/go_router.dart';
import 'package:krofile_ai/screen/customize_screen.dart';
import 'package:krofile_ai/screen/explore_screen.dart';
import 'package:krofile_ai/screen/home_screen.dart';
import 'package:krofile_ai/screen/incognito_screen.dart';
import 'package:krofile_ai/screen/mylist_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) => '/KrofileAI',
    ),
    GoRoute(
      path: '/KrofileAI',
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'mylist',
          builder: (context, state) => MyList(
            selectedCategoryIndex: state
                        .uri.queryParameters['selectedCategoryIndex'] !=
                    null
                ? int.parse(state.uri.queryParameters['selectedCategoryIndex']!)
                : 0,
            selectedSubCategoryIndex: state
                        .uri.queryParameters['selectedSubCategoryIndex'] !=
                    null
                ? int.parse(state.pathParameters['selectedSubCategoryIndex']!)
                : 0,
          ),
        ),
        GoRoute(
          path: 'explore',
          builder: (context, state) => const ExploreScreen(),
        ),
        GoRoute(
          path: 'customize',
          builder: (context, state) => const CustomizeScreen(),
        ),
        GoRoute(
          path: 'incognito',
          builder: (context, state) => const IncognitoMode(),
        ),
      ],
    ),
  ],
);
