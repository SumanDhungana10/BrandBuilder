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
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            return MyList(
              selectedCategoryIndex:
                  extra?['selectedCategoryIndex'] as int? ?? 0,
              selectedSubCategoryIndex:
                  extra?['selectedSubCategoryIndex'] as int?,
              newSubCategory: extra?['newSubCategory'] as String?,
            );
          },
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
