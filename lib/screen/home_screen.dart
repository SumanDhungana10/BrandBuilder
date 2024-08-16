import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:krofile_ai/bloc/bloc/explore_bloc.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/bloc/mylist/mylist_bloc.dart';
import 'package:krofile_ai/bloc/homescreen/homescreen_bloc.dart';
import 'package:krofile_ai/responsive.dart';
import 'package:krofile_ai/services/faq_services.dart';
import 'package:krofile_ai/widgets/business_chat.dart';
import 'package:krofile_ai/widgets/clear_chat_alert.dart';
import 'package:krofile_ai/widgets/delete_all_searchhistory_alert.dart';
import 'package:krofile_ai/widgets/feedback_alert.dart';
import 'package:krofile_ai/widgets/mobileview_sidebar.dart';
import 'package:krofile_ai/widgets/side_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<BusinessResponseBloc>().add(GetFaq());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: const SibeBarDrawer(),
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: const Color(0xFFFAFAFA),
          actions: [Container()],
          scrolledUnderElevation: 0,
          shape: const Border(
            bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/SquareLogo.png",
                        width: 48, height: 48),
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
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        textStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF151515),
                            fontWeight: FontWeight.w400),
                        padding: const EdgeInsets.fromLTRB(8, 6, 16, 6),
                        foregroundColor: const Color(0xFF151515),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                            color: Color(0xFFE5E5E5), width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      onPressed: () {
                        // context
                        //     .read<ExploreScreenBloc>()
                        //     .add(FetchExploreCategories());
                        context.read<ExploreBloc>().add(ExploreCategories());
                        context.go('/KrofileAI/explore');
                      },
                      icon: SvgPicture.asset(
                        "assets/images/apps.svg",
                        height: 16,
                        width: 16,
                      ),
                      label: const Text("Explore"),
                    ),
                    const SizedBox(width: 10),
                    BlocBuilder<MylistBloc, MylistState>(
                      builder: (context, state) {
                        return ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            textStyle: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF151515),
                                fontWeight: FontWeight.w400),
                            padding: const EdgeInsets.fromLTRB(8, 6, 16, 6),
                            foregroundColor: const Color(0xFF151515),
                            backgroundColor: Colors.white,
                            side: const BorderSide(
                                color: Color(0xFFE5E5E5), width: 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () {
                            if (state.categories.isEmpty) {
                              context.read<MylistBloc>().add(FetchCategories());
                            }
                            context.go('/KrofileAI/mylist', extra: {
                              'selectedCategoryIndex': 0,
                              'selectedSubCategoryIndex': 0,
                            });
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
                    const SizedBox(width: 10),
                    const ThreeDotMenu(),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  flex: state.isSideBarOpen ? 7 : 10,
                  child: BusinessChat(scaffoldKey: _scaffoldKey),
                ),
                if (Responsive.isDesktop(context))
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    // width: (state.isSideBarOpen) ? 400 : 0,
                    width: state.isSideBarOpen
                        ? MediaQuery.of(context).size.width * 0.25
                        : 0,
                    child: SideBar(
                      scaffoldKey: _scaffoldKey,
                    ),
                  )
                // if (Responsive.isDesktop(context))
                //   if (state.isSideBarOpen)
                //     Expanded(
                //       flex: 3,
                //       child: SideBar(
                //         scaffoldKey: _scaffoldKey,
                //       ),
                //     ),
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
  final MenuController _menuController = MenuController();

  Future<void> _viewFeedBackAlert() {
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
    return SizedBox(
      child: BlocBuilder<BusinessResponseBloc, BusinessResponseState>(
        builder: (context, state) {
          return MenuAnchor(
            controller: _menuController,
            style: const MenuStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFFFAFAFA)),
              padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
            ),
            menuChildren: [
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    MenuItemButton(
                      style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 6, vertical: 16),
                        ),
                      ),
                      child: const Text(
                        'History',
                      ),
                      onPressed: () {
                        context.read<HomeScreenBloc>().add(ToggleHistory());
                        if (state.historyList.isEmpty) {
                          context
                              .read<BusinessResponseBloc>()
                              .add(FetchHistory());
                        }
                        if (Responsive.isMobile(context)) {
                          Scaffold.of(context).openEndDrawer();
                        }
                      },
                    ),
                    MenuItemButton(
                      onPressed: _viewClearAllAlert,
                      child: const Text('Clear All Chat'),
                    ),
                    MenuItemButton(
                      child: const Text('Customize'),
                      onPressed: () {
                        context.go('/KrofileAI/customize');
                      },
                    ),
                    MenuItemButton(
                      child: const Text('Incognito Mode'),
                      onPressed: () {
                        context.go('/KrofileAI/incognito');
                      },
                    ),
                    MenuItemButton(
                      onPressed: _viewDeleteHistoryAlert,
                      child: const Text('Delete All Search History'),
                    ),
                    MenuItemButton(
                      onPressed: _viewFeedBackAlert,
                      child: const Text('Feedback'),
                    ),
                  ],
                ),
              ),
            ],
            builder: (context, controller, child) {
              return IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
