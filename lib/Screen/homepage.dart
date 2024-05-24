import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/homepage/homepage_cubit.dart';
import 'package:krofile_ai/cubit/mylist/mylist_cubit.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';
import 'package:krofile_ai/cubit/threedot/threedot_cubit.dart';
import 'package:krofile_ai/screen/customize.dart';
import 'package:krofile_ai/screen/incognito.dart';
import 'package:krofile_ai/screen/mylist.dart';
import 'package:krofile_ai/widgets/aichatting.dart';
import 'package:krofile_ai/widgets/feedbackalert.dart';
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
        appBar: AppBar(
          // elevation: 0, // Set the elevation to 0
          // surfaceTintColor: Colors.transparent,
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
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF151515),
                          fontWeight: FontWeight.w400),
                      padding: const EdgeInsets.all(10),
                      foregroundColor: const Color(0xFF151515),
                      backgroundColor: Colors.white,
                      side:
                          const BorderSide(color: Color(0xFFE5E5E5), width: 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {
                      context.read<MylistCubit>().fetchCategories();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyList()));
                    },
                    icon: SvgPicture.asset(
                      "assets/images/Bookmark.svg",
                      height: 16,
                      width: 16,
                    ),
                    label: const Text("My List"),
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

                const Expanded(
                  flex: 3,
                  child: AiChatting(),
                ),

                // if (state.isSideBarOpen)
                //   // ?
                //   const Expanded(
                //     flex: 1,
                //     child: SideBar(),
                //   )
                // Expanded(
                //     flex: 1,
                //     child: SideBar(
                //       scaffoldKey: _scaffoldKey,
                //     )),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: (state.isSideBarOpen) ? 400 : 0,
                  child: SideBar(
                    scaffoldKey: _scaffoldKey,
                  ),
                )
                // Expanded(
                //   flex: (state.isSideBarOpen) ? 3 : -2,
                //   child: AnimatedContainer(
                //     duration: const Duration(milliseconds: 300),
                //     // width: (state.isSideBarOpen) ? 320 : 0,
                //     child: const SideBar(),
                //   ),
                // )
                // Visibility(
                //   visible: state.isSideBarOpen,
                //   child: const Expanded(
                //     flex: 1,
                //     child: SideBar(),
                //   ),
                // ),
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThreedotCubit, ThreedotState>(
      builder: (context, state) {
        return PopupMenuButton(
          color: Colors.white,
          onSelected: (int result) {
            if (result == 1) {
              BlocProvider.of<ThreedotCubit>(context).toggleHistory();
            }
            if (result == 2) {
              BlocProvider.of<ResponsepageCubit>(context)
                  .resetQuestionAnswerList();
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
