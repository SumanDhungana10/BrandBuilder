import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/bloc/mylist/mylist_bloc.dart';
import 'package:krofile_ai/utils/text_parse.dart';
import 'package:krofile_ai/widgets/back_button.dart';
import 'package:krofile_ai/widgets/create_new_mylist_alert.dart';
import 'package:share_plus/share_plus.dart';

class MyList extends StatefulWidget {
  const MyList({
    super.key,
    required this.selectedCategoryIndex,
    required this.selectedSubCategoryIndex,
    this.newSubCategory,
  });
  final int selectedCategoryIndex;
  final int? selectedSubCategoryIndex;
  final String? newSubCategory;

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  int buttonindex = 1;
  String? newSubCategory;

  @override
  void initState() {
    super.initState();
    buttonindex = widget.selectedCategoryIndex;
    newSubCategory = widget.newSubCategory;
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
          const OneBackButton(),
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
                  child: BlocBuilder<MylistBloc, MylistState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.errorMessage != null) {
                        return Center(child: Text(state.errorMessage!));
                      } else {
                        final stateCategories = state.mylist
                            .map((item) => item.category.trim())
                            .toSet()
                            .toList()
                          ..sort();
                        final predefinedCategories = state.predefinedCategories;
                        final uniqueCategories = <dynamic>{
                          ...predefinedCategories,
                          ...stateCategories.where((category) =>
                              !predefinedCategories.contains(category))
                        }.toList()
                          ..sort(); //Sort alphabetically

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
                              for (int i = 0; i < uniqueCategories.length; i++)
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: buttonindex == i
                                          ? const Color(0xFFFAFAFA)
                                          : const Color(0xFFFFFFFF),
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 12, 16, 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        buttonindex = i;
                                      });
                                    },
                                    child: Text(
                                      uniqueCategories[i],
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
                    child: BlocBuilder<MylistBloc, MylistState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state.errorMessage != null) {
                          return Center(child: Text(state.errorMessage!));
                        } else {
                          final uniqueCategories = state.mylist
                              .map((item) => item.category.trim())
                              .toSet()
                              .toList()
                            ..sort();

                          if (buttonindex >= uniqueCategories.length) {
                            return const Center(
                                child: Text("You have no saved responses"));
                          }

                          final selectedCategory =
                              uniqueCategories[buttonindex];
                          final selectedCategoryItems = state.mylist
                              .where((item) =>
                                  item.category.trim() == selectedCategory)
                              .toList();

                          // Group items by subcategory
                          final groupedSubcategories =
                              <String, List<dynamic>>{};
                          for (var item in selectedCategoryItems) {
                            if (!groupedSubcategories
                                .containsKey(item.subcategory.trim())) {
                              groupedSubcategories[item.subcategory.trim()] =
                                  [];
                            }
                            groupedSubcategories[item.subcategory.trim()]!
                                .add(item);
                          }

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
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 24),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        selectedCategory,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF151515),
                                        ),
                                      ),
                                      MenuAnchor(
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
                                        menuChildren: [
                                          MenuItemButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    ClearCategoryAlert(
                                                        category:
                                                            selectedCategory),
                                              );
                                            },
                                            child: const Row(
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
                                                      color: Color(0xFFCD1F18),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        style: MenuStyle(
                                          shape: WidgetStatePropertyAll<
                                              OutlinedBorder>(
                                            RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  color: Color(0xFFCD1F18),
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                          padding: const WidgetStatePropertyAll<
                                              EdgeInsetsGeometry>(
                                            EdgeInsets.all(12),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: groupedSubcategories.length,
                                  itemBuilder: (context, subcategoryIndex) {
                                    final subcategory = groupedSubcategories
                                        .keys
                                        .elementAt(subcategoryIndex);
                                    final subcategoryItems =
                                        groupedSubcategories[subcategory]!;

                                    return ExpansionTile(
                                      initiallyExpanded: (subcategoryIndex ==
                                              widget
                                                  .selectedSubCategoryIndex) ||
                                          (newSubCategory != null &&
                                              subcategory.trim() ==
                                                  newSubCategory!.trim()),
                                      title: Text(
                                        subcategory,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF151515),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      children: [
                                        ...subcategoryItems.map((item) {
                                          return ListTile(
                                            title: RichText(
                                              text: TextSpan(
                                                children: convertToBoldText(
                                                    item.content,
                                                    fontSize: 16,
                                                    color: const Color(
                                                        0xFF151515)),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            subtitle: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () =>
                                                          Share.share(
                                                              item.content),
                                                      icon: const Icon(
                                                          Icons.share_outlined),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        Clipboard.setData(
                                                                ClipboardData(
                                                                    text: item
                                                                        .content))
                                                            .then((_) {
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      500),
                                                              content: Text(
                                                                  'Copied to your clipboard!'),
                                                            ),
                                                          );
                                                        });
                                                      },
                                                      icon: const Icon(Icons
                                                          .file_copy_outlined),
                                                    ),
                                                    PopupMenuButton(
                                                      onSelected: (value) {
                                                        if (value == 1) {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  RemoveResponse(
                                                                      id: item
                                                                          .id));
                                                        }
                                                      },
                                                      itemBuilder: (BuildContext
                                                              context) =>
                                                          <PopupMenuEntry<int>>[
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
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Color(
                                                                        0xFF151515),
                                                                  ),
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
                                                                Radius.circular(
                                                                    8.0)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 24),
                                                  child: Divider(
                                                      height: 1,
                                                      color: Color(0xFFD4D4D4)),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                        if (subcategoryItems.isNotEmpty)
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
                                                        DeletTitleAlert(
                                                            title: subcategory),
                                                  );
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

class DeletTitleAlert extends StatelessWidget {
  const DeletTitleAlert({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: const Color(0xFFFAFAFA),
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
              context.read<MylistBloc>().add(DeleteMylistByTitle(title));
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

class RemoveResponse extends StatelessWidget {
  const RemoveResponse({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: const Color(0xFFFAFAFA),
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
              context.read<MylistBloc>().add(
                    DeleteMylistById(id),
                  );
              Navigator.pop(context);
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
    required this.category,
  });

  final String category;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: const Color(0xFFFAFAFA),
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
              backgroundColor: const Color(0xFF1E7BC8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Navigator.pop(context);
              context.read<MylistBloc>().add(DeleteMylistByCategory(category));
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
