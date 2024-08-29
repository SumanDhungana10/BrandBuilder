import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:krofile_ai/bloc/explore/explore_bloc.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/bloc/mylist/mylist_bloc.dart';
import 'package:krofile_ai/bloc/homescreen/homescreen_bloc.dart';
import 'package:krofile_ai/responsive.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawer: const SibeBarDrawer(),
        appBar: AppBar(
          toolbarHeight: 70,
          // backgroundColor: const Color(0xFFFAFAFA),
          backgroundColor: const Color(0xFFFFFFFF),
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
                            context.go('/KrofileAI/mylist', extra: {
                              'selectedCategoryIndex': 0,
                              'selectedSubCategoryIndex': 0,
                            });
                            context.read<MylistBloc>().add(FetchMylist());
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
  const ThreeDotMenu({super.key});

  @override
  State<ThreeDotMenu> createState() => _ThreeDotMenuState();
}

class _ThreeDotMenuState extends State<ThreeDotMenu> {
  final MenuController _menuController = MenuController();

  Future<void> _viewFeedBackAlert() {
    return showDialog(
      barrierColor: const Color(0xFF000000).withOpacity(0.8),
      context: context,
      builder: (BuildContext context) => const FeedBackAlert(),
    );
  }

  Future<void> _viewClearAllAlert() {
    return showDialog(
      barrierColor: const Color(0xFF000000).withOpacity(0.8),
      context: context,
      builder: (BuildContext context) => const ClearAllChatAlert(),
    );
  }

  Future<void> _viewDeleteHistoryAlert() {
    return showDialog(
      barrierColor: const Color(0xFF000000).withOpacity(0.8),
      context: context,
      builder: (BuildContext context) => const DeletAllSearchHistoryAlert(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusinessResponseBloc, BusinessResponseState>(
      builder: (context, state) {
        return MenuAnchor(
          controller: _menuController,
          style: MenuStyle(
            backgroundColor: WidgetStateProperty.all(Colors.white),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            elevation: WidgetStateProperty.all(8),
            shadowColor: WidgetStateProperty.all(Colors.black.withOpacity(1)),
          ),
          menuChildren: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildMenuItem('History', () {
                  context.read<HomeScreenBloc>().add(ToggleHistory());
                  context.read<BusinessResponseBloc>().add(FetchHistory());
                  if (Responsive.isMobile(context)) {
                    Scaffold.of(context).openEndDrawer();
                  }
                }),
                _buildMenuItem('Clear All Chat', _viewClearAllAlert),
                _buildMenuItem(
                    'Customize', () => context.go('/KrofileAI/customize')),
                _buildMenuItem(
                    'Incognito Mode', () => context.go('/KrofileAI/incognito')),
                _buildMenuItem(
                    'Delete All Search History', _viewDeleteHistoryAlert),
                _buildMenuItem('Feedback', _viewFeedBackAlert, isLast: true),
              ],
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
    );
  }

  Widget _buildMenuItem(String title, VoidCallback onPressed,
      {bool isLast = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: () {
            _menuController.close();
            onPressed();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              title,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ),
        if (!isLast)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFE0E0E0), // Light grey color for the divider
          ),
      ],
    );
  }
}
