import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/cubit/mylist/mylist_cubit.dart';
import 'package:krofile_ai/screen/home_page.dart';
import 'package:krofile_ai/widgets/create_new_mylist_alert.dart';

class MyList extends StatefulWidget {
  const MyList(
      {super.key,
      required this.selectedCategoryIndex,
      required this.selectedSubCategoryIndex});
  final int selectedCategoryIndex;
  final int? selectedSubCategoryIndex;

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  int buttomindex = 0;
  @override
  void initState() {
    super.initState();
    buttomindex = widget.selectedCategoryIndex;
  }

  Future<dynamic> createNewMylist(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return const CreateNewMylistAlert();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.fromLTRB(
        32,
        24,
        32,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back_ios_new_sharp,
                  size: 16,
                  color: Color(0xFF73767B),
                ),
                SizedBox(width: 10),
                Text(
                  "Back",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF73767B)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Mylist",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                color: Color(0xFF151515)),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12, bottom: 24),
            child: Divider(
              height: 1,
              color: Color(0xFF73767B),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: BlocBuilder<MylistCubit, MylistState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.errorMessage != null) {
                        return Center(child: Text(state.errorMessage!));
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFD4D4D4)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Collection",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF15141A),
                                ),
                              ),
                              for (int i = 0; i < state.categories.length; i++)
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 12, 16, 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        buttomindex = i;
                                      });
                                    },
                                    child: Text(
                                      state.categories[i].name,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF15141A),
                                      ),
                                    ),
                                  ),
                                ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  alignment: Alignment.topCenter,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 12, 16, 12),
                                ),
                                onPressed: () {
                                  createNewMylist(context);
                                },
                                child: const Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Create new",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF15141A),
                                      ),
                                    ),
                                    Icon(Icons.add)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 32,
                ),
                Expanded(
                    flex: 4,
                    child: BlocBuilder<MylistCubit, MylistState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state.errorMessage != null) {
                          return Center(child: Text(state.errorMessage!));
                        } else {
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.search),
                                    hintText: "Search",
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
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 24, bottom: 24),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(state.categories[buttomindex].name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF151515),
                                          )),
                                      PopupMenuButton(
                                        onSelected: (value) {
                                          if (value == 1) {
                                            // context
                                            //     .read<MylistCubit>()
                                            //     .clearCategory(buttomindex);
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    ClearCategoryAlert(
                                                        buttomindex:
                                                            buttomindex));
                                          }
                                        },
                                        padding: const EdgeInsets.all(12),
                                        itemBuilder: (BuildContext context) =>
                                            <PopupMenuEntry<int>>[
                                          const PopupMenuItem<int>(
                                            value: 1,
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete_outlined,
                                                    color: Color(0xFFCD1F18),
                                                    size: 21),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 8),
                                                  child: Text(
                                                    'Clear',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color:
                                                            Color(0xFFCD1F18)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Color(0xFFCD1F18),
                                              width: 2),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: state.categories[buttomindex]
                                      .subcategories.length,
                                  itemBuilder: (context, subcategoryIndex) {
                                    final subcategory = state
                                        .categories[buttomindex]
                                        .subcategories[subcategoryIndex];
                                    return ExpansionTile(
                                      initiallyExpanded: (subcategoryIndex ==
                                              widget.selectedSubCategoryIndex)
                                          ? true
                                          : false,
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            subcategory.name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF151515),
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      children: [
                                        ...subcategory.responses
                                            .map((response) {
                                          return ListTile(
                                              title: Text(response,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0xFF151515),
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              subtitle: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(Icons
                                                              .share_outlined)),
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(Icons
                                                              .file_copy_outlined)),
                                                      PopupMenuButton(
                                                        onSelected: (value) {
                                                          if (value == 1) {
                                                            context
                                                                .read<
                                                                    MylistCubit>()
                                                                .deleteResponse(
                                                                  buttomindex,
                                                                  subcategoryIndex,
                                                                  subcategory
                                                                      .responses
                                                                      .indexOf(
                                                                          response),
                                                                );
                                                          }
                                                        },
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context) =>
                                                                <PopupMenuEntry<
                                                                    int>>[
                                                          const PopupMenuItem<
                                                              int>(
                                                            value: 1,
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                    Icons
                                                                        .close_outlined,
                                                                    color: Color(
                                                                        0xFF151515),
                                                                    size: 21),
                                                                Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              8),
                                                                  child: Text(
                                                                    'Remove from collection',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: Color(
                                                                            0xFF151515)),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                        shape:
                                                            const RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color: Color(
                                                                  0xFFD4D4D4),
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          8.0)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 24, bottom: 24),
                                                    child: Divider(
                                                      height: 1,
                                                      color: Color(0xFFD4D4D4),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        }),
                                        if (state
                                            .categories[buttomindex]
                                            .subcategories[subcategoryIndex]
                                            .responses
                                            .isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: TextButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          DeletSubCategoryAlert(
                                                              buttomindex:
                                                                  buttomindex,
                                                              subcategoryIndex:
                                                                  subcategoryIndex));
                                                },
                                                icon: const Icon(
                                                  Icons.delete_outlined,
                                                  color: Color(0xFFCD1F18),
                                                ),
                                                label: const Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Color(0xFFCD1F18)),
                                                )),
                                          )
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          );
                        }
                      },
                    )),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

class DeletSubCategoryAlert extends StatelessWidget {
  const DeletSubCategoryAlert({
    super.key,
    required this.buttomindex,
    required this.subcategoryIndex,
  });

  final int buttomindex;
  final int subcategoryIndex;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      contentPadding: const EdgeInsets.all(24),
      title: const Row(
        children: [
          Icon(
            Icons.error,
            color: Color(0xFFFF8C22),
          ),
          SizedBox(width: 10),
          Text(
            "Do you want to delete the saved responses?",
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF151515),
                fontWeight: FontWeight.w400),
          )
        ],
      ),
      actions: [
        TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              backgroundColor: const Color(0xFFCCCCCC),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel",
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF151515),
                    fontWeight: FontWeight.w400))),
        const SizedBox(
          width: 10,
        ),
        TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              backgroundColor: const Color(0xFF21201F),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<MylistCubit>()
                  .deleteSubCategory(buttomindex, subcategoryIndex);
            },
            child: const Text("Continue",
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w400)))
      ],
    );
  }
}

class ClearCategoryAlert extends StatelessWidget {
  const ClearCategoryAlert({
    super.key,
    required this.buttomindex,
  });

  final int buttomindex;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      contentPadding: const EdgeInsets.all(24),
      title: const Row(
        children: [
          Icon(
            Icons.error,
            color: Color(0xFFFF8C22),
          ),
          SizedBox(width: 10),
          Text(
            "Do you want to clear the collection from the list?",
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF151515),
                fontWeight: FontWeight.w400),
          )
        ],
      ),
      actions: [
        TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              backgroundColor: const Color(0xFFCCCCCC),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel",
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF151515),
                    fontWeight: FontWeight.w400))),
        const SizedBox(
          width: 10,
        ),
        TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              backgroundColor: const Color(0xFF21201F),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Navigator.pop(context);
              context.read<MylistCubit>().clearCategory(
                    buttomindex,
                  );
            },
            child: const Text("Continue",
                style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w400)))
      ],
    );
  }
}
