import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/explore/explore_cubit.dart';
import 'package:krofile_ai/cubit/responsepage/responsepage_cubit.dart';
import 'package:krofile_ai/screen/home_page.dart';

class ExplorePgaeMobileView extends StatefulWidget {
  const ExplorePgaeMobileView({super.key});

  @override
  State<ExplorePgaeMobileView> createState() => _ExplorePgaeMobileViewState();
}

class _ExplorePgaeMobileViewState extends State<ExplorePgaeMobileView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreCubit, ExploreState>(
      builder: (context, state) {
        return Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
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
                                backgroundColor:
                                    (state.actveCategoryIndex == index)
                                        ? const Color(0xFF18C554)
                                        : const Color(0xFFFFFFFF),
                                foregroundColor:
                                    (state.actveCategoryIndex == index)
                                        ? const Color(0xFFFFFFFF)
                                        : const Color(0xFF73767B),
                                padding:
                                    const EdgeInsets.fromLTRB(12.8, 8, 12.8, 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.4),
                                  side: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                ),
                              ),
                              child: Text(
                                state.categories[index].name,
                                style: const TextStyle(
                                  fontSize: 12,
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
                                  backgroundColor:
                                      (state.actveCategoryIndex == index)
                                          ? const Color(0xFF18C554)
                                          : const Color(0xFFFFFFFF),
                                  foregroundColor:
                                      (state.actveCategoryIndex == index)
                                          ? const Color(0xFFFFFFFF)
                                          : const Color(0xFF73767B),
                                  padding: const EdgeInsets.fromLTRB(
                                      12.8, 8, 12.8, 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.4),
                                    side: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                ),
                                child: Text(
                                  state.categories[index].name,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (state.categories[state.actveCategoryIndex].subcategories.isEmpty)
                ? Container()
                : Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFE5E5E5),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: DropdownButton<String>(
                        underline: Container(),
                        icon: SvgPicture.asset(
                            'assets/images/fe_arrow-right.svg'),
                        focusColor: Theme.of(context).scaffoldBackgroundColor,
                        value: state.categories[state.actveCategoryIndex]
                            .subcategories[state.activeSubCategoryIndex].name,
                        onChanged: (String? newValue) {
                          final index = state
                              .categories[state.actveCategoryIndex]
                              .subcategories
                              .indexWhere(
                                  (element) => element.name == newValue);
                          context
                              .read<ExploreCubit>()
                              .setActiveSubCategory(index);
                        },
                        items: state
                            .categories[state.actveCategoryIndex].subcategories
                            .map<DropdownMenuItem<String>>((subcategory) {
                          return DropdownMenuItem<String>(
                            value: subcategory.name,
                            child: Text(
                              subcategory.name,
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
            (state.categories[state.actveCategoryIndex].subcategories.isEmpty ||
                    state
                        .categories[state.actveCategoryIndex]
                        .subcategories[state.activeSubCategoryIndex]
                        .items
                        .isEmpty)
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFD4D4D4),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state
                          .categories[state.actveCategoryIndex]
                          .subcategories[state.activeSubCategoryIndex]
                          .items
                          .length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFFD4D4D4),
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              state
                                  .categories[state.actveCategoryIndex]
                                  .subcategories[state.activeSubCategoryIndex]
                                  .items[index],
                              style: const TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                              BlocProvider.of<ResponsepageCubit>(context)
                                  .handelQuestionType();
                              BlocProvider.of<ResponsepageCubit>(context)
                                  .addQuestionAnswerList(state
                                      .categories[state.actveCategoryIndex]
                                      .subcategories[
                                          state.activeSubCategoryIndex]
                                      .items[index]);
                            },
                          ),
                        );
                      },
                    ),
                  )
          ],
        );
      },
    );
  }
}
