import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/explore/explore_cubit.dart';
import 'package:krofile_ai/cubit/homepage/homepage_cubit.dart';
import 'package:krofile_ai/cubit/mylist/mylist_cubit.dart';
import 'package:krofile_ai/cubit/homepage_popupmenu/homepage_popup_cubit.dart';
import 'package:krofile_ai/responsive.dart';
import 'package:krofile_ai/screen/customize_page.dart';
import 'package:krofile_ai/screen/incognito_page.dart';
import 'package:krofile_ai/screen/mylist.dart';
import 'package:krofile_ai/widgets/ai_chatting.dart';
import 'package:krofile_ai/widgets/clear_chat_alert.dart';
import 'package:krofile_ai/widgets/delete_all_searchhistory_alert.dart';
import 'package:krofile_ai/widgets/feedback_alert.dart';
import 'package:krofile_ai/widgets/mobileview_sidebar.dart';
import 'package:krofile_ai/widgets/side_bar.dart';

import 'explore_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: const SibeBarDrawer(),
        appBar: AppBar(
          actions: [Container()],
          scrolledUnderElevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset("assets/images/SquareLogo.png",
                      width: 50, height: 50),
                  const SizedBox(width: 10),
                  const Text("Krofile AI",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF15141A),
                          fontWeight: FontWeight.w600)),
                ],
              ),
              Row(
                children: [
                  BlocBuilder<HomepageCubit, HomepageState>(
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF151515),
                              fontWeight: FontWeight.w400),
                          padding: const EdgeInsets.all(10),
                          foregroundColor: const Color(0xFF151515),
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                              color: Color(0xFFE5E5E5), width: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          context.read<ExploreCubit>().fetchCategories();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ExplorePage()));
                        },
                        icon: SvgPicture.asset(
                          "assets/images/apps.svg",
                          height: 16,
                          width: 16,
                        ),
                        label: const Text("Explore"),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  BlocBuilder<MylistCubit, MylistState>(
                    builder: (context, state) {
                      return ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          textStyle: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF151515),
                              fontWeight: FontWeight.w400),
                          padding: const EdgeInsets.all(10),
                          foregroundColor: const Color(0xFF151515),
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                              color: Color(0xFFE5E5E5), width: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        onPressed: () {
                          if (state.categories.isEmpty) {
                            context.read<MylistCubit>().fetchCategories();
                          }
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyList(
                                        selectedCategoryIndex: 0,
                                        selectedSubCategoryIndex: 0,
                                      )));
                        },
                        icon: SvgPicture.asset(
                          "assets/images/Bookmark.svg",
                          height: 16,
                          width: 16,
                        ),
                        label: const Text("My List"),
                      );
                    },
                  ),
                  const ThreeDotMenu(),
                ],
              ),
            ],
          ),
        ),
        body: BlocBuilder<HomepageCubit, HomepageState>(
          builder: (context, state) {
            return Row(
              children: [
                // (state.isSideBarOpen)

                Expanded(
                  flex: 3,
                  child: AiChatting(scaffoldKey: _scaffoldKey),
                ),
                if (Responsive.isDesktop(context))
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: (state.isSideBarOpen) ? 400 : 0,
                    child: SideBar(
                      scaffoldKey: _scaffoldKey,
                    ),
                  )
              ],
            );
          },
        ));
  }
}

class ThreeDotMenu extends StatefulWidget {
  const ThreeDotMenu({
    super.key,
  });

  @override
  State<ThreeDotMenu> createState() => _ThreeDotMenuState();
}

class _ThreeDotMenuState extends State<ThreeDotMenu> {
  Future<void> _viewFeedBaclAlert() {
    return showDialog(
        barrierColor: const Color(0xFF000000).withOpacity(0.8),
        context: context,
        builder: (BuildContext context) {
          return const FeedBackAlert();
        });
  }

  Future<void> _viewClearAllAlert() {
    return showDialog(
        barrierColor: const Color(0xFF000000).withOpacity(0.8),
        context: context,
        builder: (BuildContext context) {
          return const ClearAllChatAlert();
        });
  }

  Future<void> _viewDeleteHistoryAlert() {
    return showDialog(
        barrierColor: const Color(0xFF000000).withOpacity(0.8),
        context: context,
        builder: (BuildContext context) {
          return const DeletAllSearchHistoryAlert();
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThreedotCubit, ThreedotState>(
      builder: (context, state) {
        return PopupMenuButton(
          color: Colors.white,
          onSelected: (int result) {
            if (result == 1) {
              BlocProvider.of<ThreedotCubit>(context).toggleHistory();
              Scaffold.of(context).openEndDrawer();
            }
            if (result == 2) {
              // BlocProvider.of<ResponsepageCubit>(context)
              //     .resetQuestionAnswerList();
              _viewClearAllAlert();
            }
            if (result == 3) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CustomizePage()));
            }
            if (result == 4) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const IncognitoMode()));
            }
            if (result == 5) {
              _viewDeleteHistoryAlert();
            }
            if (result == 6) {
              _viewFeedBaclAlert();
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
            const PopupMenuItem<int>(
              value: 1,
              child: ListTile(
                title: Text('History '),
              ),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: ListTile(
                title: Text('Clear All Chat'),
              ),
            ),
            const PopupMenuItem<int>(
              value: 3,
              child: ListTile(
                title: Text('Customize'),
              ),
            ),
            const PopupMenuItem<int>(
              value: 4,
              child: ListTile(
                title: Text('Incognito Mode'),
              ),
            ),
            const PopupMenuItem<int>(
              value: 5,
              child: ListTile(
                title: Text('Delete All Search History'),
              ),
            ),
            const PopupMenuItem<int>(
              value: 6,
              child: ListTile(
                title: Text('Feedback'),
              ),
            ),
          ],
        );
      },
    );
  }
}
