import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/homepage/homepage_cubit.dart';
import 'package:krofile_ai/widgets/aichatting.dart';
import 'package:krofile_ai/widgets/side_bar.dart';

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
                  Image.asset("assets/images/logo.png", width: 50, height: 50),
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
                      textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF151515),
                          fontWeight: FontWeight.w400),
                      padding: const EdgeInsets.all(8),
                      foregroundColor: const Color(0xFF151515),
                      backgroundColor: Colors.white,
                      side:
                          const BorderSide(color: Color(0xFFE5E5E5), width: 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      "assets/images/apps.svg",
                      height: 16,
                      width: 16,
                    ),
                    label: const Text("Explore"),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF151515),
                          fontWeight: FontWeight.w400),
                      padding: const EdgeInsets.all(8),
                      foregroundColor: const Color(0xFF151515),
                      backgroundColor: Colors.white,
                      side:
                          const BorderSide(color: Color(0xFFE5E5E5), width: 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {},
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

class ThreeDotMenu extends StatelessWidget {
  const ThreeDotMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      onSelected: (int result) {},
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
  }
}
