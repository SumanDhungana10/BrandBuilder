import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/explore/explore_cubit.dart';
import 'package:krofile_ai/responsive.dart';
import 'package:krofile_ai/screen/home_page.dart';
import 'package:krofile_ai/widgets/explorepage_desktop_view.dart';
import 'package:krofile_ai/widgets/explorepage_mobile_view.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (Responsive.isDesktop(context))
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE5E5E5), width: 1.0))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 24, 32, 12),
                  child: Row(
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            context.read<ExploreCubit>().resetCategory();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          icon: const Icon(Icons.arrow_back_ios,
                              size: 16, color: Color(0xFF73767B)),
                          label: const Text("Back",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF73767B),
                                  fontWeight: FontWeight.w400))),
                      const SizedBox(width: 24),
                      Flexible(
                        fit: FlexFit.loose,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            hintText: 'Message Krofile...',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFF18C554),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: SvgPicture.asset(
                                    "assets/images/send.svg",
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            if (Responsive.isMobile(context))
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE5E5E5), width: 1.0))),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        },
                        icon: const Icon(Icons.arrow_back_ios,
                            size: 16, color: Color(0xFF73767B)),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        fit: FlexFit.loose,
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(8),
                            hintText: 'Message Krofile...',
                            hintStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8),
                              child: IconButton(
                                style: IconButton.styleFrom(
                                    padding: const EdgeInsets.all(3.6),
                                    backgroundColor: const Color(0xFF18C554),
                                    shape: const CircleBorder()),
                                icon: SvgPicture.asset(
                                  "assets/images/send.svg",
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            BlocBuilder<ExploreCubit, ExploreState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.errorMessage != null) {
                  return Center(
                    child: Text(state.errorMessage!),
                  );
                } else {
                  return (!state.showSubCategory)
                      ? Padding(
                          padding: const EdgeInsets.only(left: 32, top: 32),
                          child: Wrap(
                            runSpacing: 12,
                            spacing: 12,
                            children: [
                              for (int index = 0;
                                  index < state.categories.length;
                                  index++)
                                ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<ExploreCubit>()
                                        .handelCategoryButton(index);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor:
                                        (state.actveCategoryIndex == index)
                                            ? const Color(0xFF18C554)
                                            : const Color(0xFFFFFFFF),
                                    foregroundColor:
                                        (state.actveCategoryIndex == index)
                                            ? const Color(0xFFFFFFFF)
                                            : const Color(0xFF73767B),
                                    padding: const EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      side: const BorderSide(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                  ),
                                  child: Text(
                                    state.categories[index].name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        )
                      : (Responsive.isDesktop(context))
                          ? const ExplorePageDeskTop()
                          : const ExplorePgaeMobileView();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
