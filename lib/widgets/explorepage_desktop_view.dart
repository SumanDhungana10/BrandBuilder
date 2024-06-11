import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/cubit/explore/explore_cubit.dart';
import 'package:krofile_ai/cubit/homepage/homepage_cubit.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';
import 'package:krofile_ai/screen/home_page.dart';

class ExplorePageDeskTop extends StatefulWidget {
  const ExplorePageDeskTop({super.key});

  @override
  State<ExplorePageDeskTop> createState() => _ExplorePageDeskTopState();
}

class _ExplorePageDeskTopState extends State<ExplorePageDeskTop> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollBothRows() {
    final offset =
        _scrollController.offset + 1000; // Adjust the scroll distance as needed
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void scrolltoleft() {
    final offset =
        _scrollController.offset - 1000; // Adjust the scroll distance as needed
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollListener() {
    if (_scrollController.offset > 0) {
      context.read<ExploreCubit>().showLeftButton();
    } else {
      context.read<ExploreCubit>().hideLeftButton();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        final activeIndex = state.actveCategoryIndex;
        final activeSubCategoryIndex = state.activeSubCategoryIndex;
        return Padding(
          padding: const EdgeInsets.only(left: 32, top: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            for (int index = 0;
                                index < state.categories.length / 2;
                                index++)
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: ElevatedButton(
                                  onPressed: () {
                                    context
                                        .read<ExploreCubit>()
                                        .handelCategoryButton(index);
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
                              ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Row(
                            children: [
                              for (int index = state.categories.length ~/ 2;
                                  index < state.categories.length;
                                  index++)
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context
                                          .read<ExploreCubit>()
                                          .handelCategoryButton(index);
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
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  if (state.showLeftButton)
                    Positioned(
                      left: 32,
                      child: IconButton(
                        onPressed: scrolltoleft,
                        style: IconButton.styleFrom(
                          shape: const CircleBorder(
                            side: BorderSide(color: Colors.grey, width: 1.0),
                          ),
                        ),
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 12,
                        ),
                      ),
                    ),
                  Positioned(
                    right: 32,
                    child: IconButton(
                      onPressed: scrollBothRows,
                      style: IconButton.styleFrom(
                        shape: const CircleBorder(
                          side: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(top: 32, right: 32),
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
                      child: state.categories[activeIndex].subcategories.isEmpty
                          ? const Center(
                              child: Text("No subcategories"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: state
                                  .categories[activeIndex].subcategories.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      alignment: Alignment.centerLeft,
                                      elevation: 0,
                                      backgroundColor:
                                          (activeSubCategoryIndex == index)
                                              ? const Color(0xFF18C554)
                                              : const Color(0xFFFFFFFF),
                                      foregroundColor:
                                          (activeSubCategoryIndex == index)
                                              ? const Color(0xFFFFFFFF)
                                              : const Color(0xFF73767B),
                                      padding: const EdgeInsets.all(16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        side: const BorderSide(
                                            color: Colors.grey, width: 1.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      context
                                          .read<ExploreCubit>()
                                          .setActiveSubCategory(index);
                                    },
                                    child: Text(
                                        state.categories[activeIndex]
                                            .subcategories[index].name,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        )),
                                  ),
                                );
                              },
                            ),
                    ),
                    const SizedBox(width: 34),
                    Expanded(
                      flex: 4,
                      child: state.categories[activeIndex].subcategories
                                  .isEmpty ||
                              state
                                  .categories[activeIndex]
                                  .subcategories[activeSubCategoryIndex]
                                  .items
                                  .isEmpty
                          ? const Center(
                              child: Text("No items"),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: state
                                  .categories[activeIndex]
                                  .subcategories[activeSubCategoryIndex]
                                  .items
                                  .length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 24),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xFFE5E5E5),
                                              width: 1.0))),
                                  padding: const EdgeInsets.only(
                                    bottom: 24,
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      state
                                          .categories[activeIndex]
                                          .subcategories[activeSubCategoryIndex]
                                          .items[index],
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF151515)),
                                    ),
                                    trailing: BlocBuilder<HomepageCubit,
                                        HomepageState>(
                                      builder: (context, state) {
                                        return IconButton(
                                          icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Color(
                                              0xFF151515,
                                            ),
                                            size: 16,
                                          ),
                                          onPressed: () {},
                                        );
                                      },
                                    ),
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomePage()));
                                      BlocProvider.of<ResponsepageCubit>(
                                              context)
                                          .handelQuestionType();
                                      BlocProvider.of<ResponsepageCubit>(
                                              context)
                                          .addQuestionAnswerList(state
                                              .categories[
                                                  state.actveCategoryIndex]
                                              .subcategories[
                                                  state.activeSubCategoryIndex]
                                              .items[index]);
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
