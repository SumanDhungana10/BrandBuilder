import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/explore/explore_cubit.dart';
import 'package:krofile_ai/screen/home_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with TickerProviderStateMixin {
  final ScrollController _firstScrollController = ScrollController();
  final ScrollController _secondScrollController = ScrollController();
  int activeIndex = 0;
  int activeSubCategoryIndex = 0;
  bool showSubCategory = false;

  // void _scrollToNext(ScrollController controller) {
  //   if (controller.hasClients) {
  //     final maxScrollExtent = controller.position.maxScrollExtent;
  //     final currentScrollPosition = controller.position.pixels;
  //     final width = MediaQuery.of(context).size.width;
  //     final nextScrollPosition = currentScrollPosition + width / 2;

  //     controller.animateTo(
  //       nextScrollPosition > maxScrollExtent
  //           ? maxScrollExtent
  //           : nextScrollPosition,
  //       duration: const Duration(milliseconds: 300),
  //       curve: Curves.easeInOut,
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Color(0xFFE5E5E5), width: 1.0))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(32, 24, 32, 12),
              child: Row(
                children: [
                  TextButton.icon(
                      onPressed: () {
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
          Padding(
            padding: const EdgeInsets.only(left: 32, top: 32),
            child: BlocBuilder<ExploreCubit, ExploreState>(
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
                  return (!showSubCategory)
                      ? Wrap(
                          runSpacing: 12,
                          spacing: 12,
                          children: [
                            for (int index = 0;
                                index < state.categories.length;
                                index++)
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    activeIndex = index;
                                    showSubCategory = true;
                                    activeSubCategoryIndex =
                                        0; // Reset subcategory index
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: (activeIndex == index)
                                      ? const Color(0xFF18C554)
                                      : const Color(0xFFFFFFFF),
                                  foregroundColor: (activeIndex == index)
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
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Column(
                                  children: [
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      controller: _firstScrollController,
                                      child: Row(
                                        children: [
                                          for (int index = 0;
                                              index <
                                                  state.categories.length / 2;
                                              index++)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    activeIndex = index;
                                                    showSubCategory = true;
                                                    activeSubCategoryIndex =
                                                        0; // Reset subcategory index
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor:
                                                      (activeIndex == index)
                                                          ? const Color(
                                                              0xFF18C554)
                                                          : const Color(
                                                              0xFFFFFFFF),
                                                  foregroundColor:
                                                      (activeIndex == index)
                                                          ? const Color(
                                                              0xFFFFFFFF)
                                                          : const Color(
                                                              0xFF73767B),
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    side: const BorderSide(
                                                        color: Colors.grey,
                                                        width: 1.0),
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
                                            ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: SingleChildScrollView(
                                        controller: _secondScrollController,
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            for (int index =
                                                    state.categories.length ~/
                                                        2;
                                                index < state.categories.length;
                                                index++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      activeIndex = index;
                                                      showSubCategory = true;
                                                      activeSubCategoryIndex =
                                                          0; // Reset subcategory index
                                                    });
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    backgroundColor:
                                                        (activeIndex == index)
                                                            ? const Color(
                                                                0xFF18C554)
                                                            : const Color(
                                                                0xFFFFFFFF),
                                                    foregroundColor:
                                                        (activeIndex == index)
                                                            ? const Color(
                                                                0xFFFFFFFF)
                                                            : const Color(
                                                                0xFF73767B),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      side: const BorderSide(
                                                          color: Colors.grey,
                                                          width: 1.0),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    state
                                                        .categories[index].name,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  right: 32,
                                  child: IconButton(
                                    onPressed: () {
                                      // _scrollToNext(_firstScrollController);
                                      // _scrollToNext(_secondScrollController);
                                    },
                                    style: IconButton.styleFrom(
                                      shape: const CircleBorder(
                                        side: BorderSide(
                                            color: Colors.grey, width: 1.0),
                                      ),
                                    ),
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_rounded),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 32, left: 32, right: 32),
                              child: Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: const Color(0xFFE5E5E5),
                                      width: 1.0,
                                    )),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: state.categories[activeIndex]
                                              .subcategories.isEmpty
                                          ? const Center(
                                              child: Text("No subcategories"),
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: state
                                                  .categories[activeIndex]
                                                  .subcategories
                                                  .length,
                                              itemBuilder: (context, index) {
                                                return ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      activeSubCategoryIndex =
                                                          index;
                                                    });
                                                  },
                                                  child: Text(
                                                    state
                                                        .categories[activeIndex]
                                                        .subcategories[index]
                                                        .name,
                                                  ),
                                                );
                                              },
                                            ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: state.categories[activeIndex]
                                                  .subcategories.isEmpty ||
                                              state
                                                  .categories[activeIndex]
                                                  .subcategories[
                                                      activeSubCategoryIndex]
                                                  .items
                                                  .isEmpty
                                          ? const Center(
                                              child: Text("No items"),
                                            )
                                          : Container(
                                              color: Colors.blue,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: state
                                                    .categories[activeIndex]
                                                    .subcategories[
                                                        activeSubCategoryIndex]
                                                    .items
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    title: Text(state
                                                        .categories[activeIndex]
                                                        .subcategories[
                                                            activeSubCategoryIndex]
                                                        .items[index]),
                                                  );
                                                },
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
