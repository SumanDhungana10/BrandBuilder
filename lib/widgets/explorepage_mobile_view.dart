import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/bloc/explore/explore_bloc.dart';
import 'package:krofile_ai/bloc/businessresponse/business_response_bloc.dart';
import 'package:krofile_ai/screen/home_screen.dart';

class ExplorePgaeMobileView extends StatefulWidget {
  const ExplorePgaeMobileView({super.key});

  @override
  State<ExplorePgaeMobileView> createState() => _ExplorePgaeMobileViewState();
}

class _ExplorePgaeMobileViewState extends State<ExplorePgaeMobileView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExploreBloc, ExploreState>(
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
                                // context
                                //     .read<ExploreScreenBloc>()
                                //     .add(HandleCategoryButton(index));
                                context
                                    .read<ExploreBloc>()
                                    .add(HandelCategoryButton(index));
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor:
                                    (state.activeCategoryIndex == index)
                                        ? const Color(0xFF54A5EA)
                                        : const Color(0xFFFFFFFF),
                                foregroundColor:
                                    (state.activeCategoryIndex == index)
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
                                state.categories[index],
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
                                  // context
                                  //     .read<ExploreScreenBloc>()
                                  //     .add(HandleCategoryButton(index));
                                  context
                                      .read<ExploreBloc>()
                                      .add(HandelCategoryButton(index));
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor:
                                      (state.activeCategoryIndex == index)
                                          ? const Color(0xFF54A5EA)
                                          : const Color(0xFFFFFFFF),
                                  foregroundColor:
                                      (state.activeCategoryIndex == index)
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
                                  state.categories[index],
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
            (state.subCategories.isEmpty)
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
                        value:
                            state.subCategories[state.activeSubCategoryIndex],
                        onChanged: (String? newValue) {
                          final index = state.subCategories
                              .indexWhere((element) => element == newValue);
                          context
                              .read<ExploreBloc>()
                              .add(HandelSubCategoryButton(index));
                          context.read<ExploreBloc>().add(FetchQuestions());
                        },
                        items: state.subCategories
                            .map<DropdownMenuItem<String>>((subcategory) {
                          return DropdownMenuItem<String>(
                            value: subcategory,
                            child: Text(
                              subcategory,
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
            (state.subCategories.isEmpty || state.questions.isEmpty)
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
                      itemCount: state.questions.length,
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
                              state.questions[index],
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
                                      builder: (context) =>
                                          const HomeScreen()));
                              BlocProvider.of<BusinessResponseBloc>(context)
                                  .add(HandleQuestionType());
                              BlocProvider.of<BusinessResponseBloc>(context)
                                  .add(AddQuestionAnswerList(
                                      state.questions[index]));
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
