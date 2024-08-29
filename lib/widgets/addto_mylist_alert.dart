
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:krofile_ai/bloc/mylist/mylist_bloc.dart';

class AddToMyList extends StatefulWidget {
  const AddToMyList({super.key, required this.answer});
  final String answer;

  @override
  State<AddToMyList> createState() => _AddToMyListState();
}

class _AddToMyListState extends State<AddToMyList> {
  final TextEditingController _newSubCategory = TextEditingController();
  String _selectedCategory = "";
  String? _selectedSubCategory;
  int? _selectedCategoryIndex;

  @override
  void initState() {
    super.initState();
    _newSubCategory.addListener(_onTextFieldChange);
  }

  @override
  void dispose() {
    _newSubCategory.removeListener(_onTextFieldChange);
    _newSubCategory.dispose();
    super.dispose();
  }

  void _onTextFieldChange() {
    setState(() {
      // This empty setState will trigger a rebuild
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: const Color(0xFFFAFAFA),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      titlePadding: const EdgeInsets.all(0),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        width: 480,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFD4D4D4), width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("My List",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF151515),
                )),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
      content: BlocBuilder<MylistBloc, MylistState>(
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
              ...stateCategories
                  .where((category) => !predefinedCategories.contains(category))
            }.toList()
              ..sort();

            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < uniqueCategories.length; i++) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(uniqueCategories[i],
                            style: const TextStyle(
                              color: Color(0xFF151515),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            )),
                        Radio(
                          value: uniqueCategories[i],
                          groupValue: _selectedCategory,
                          activeColor: const Color(0xFF1E7BC8),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value.toString();
                              _selectedSubCategory = null;
                              _selectedCategoryIndex = i;
                            });
                          },
                        ),
                      ],
                    ),
                    if (_selectedCategory == uniqueCategories[i])
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (state.mylist.any(
                              (item) => item.category == _selectedCategory))
                            DropdownButtonFormField<String>(
                              isExpanded: true,
                              icon: SvgPicture.asset(
                                "assets/images/fe_arrow-right.svg",
                              ),
                              focusColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              value: _selectedSubCategory,
                              decoration: const InputDecoration(
                                hintText: "--Select response name--*",
                                hintStyle: TextStyle(
                                  color: Color(0xFF151515),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFD4D4D4)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  borderSide:
                                      BorderSide(color: Color(0xFFD4D4D4)),
                                ),
                              ),
                              items: state.mylist
                                  .where((item) =>
                                      item.category == _selectedCategory)
                                  .map((item) => item.subcategory)
                                  .toSet()
                                  .map((String subcategory) {
                                return DropdownMenuItem<String>(
                                  value: subcategory,
                                  child: Text(subcategory),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedSubCategory = newValue;
                                  if (newValue != null) {
                                    _newSubCategory.text = newValue;
                                  }
                                });
                              },
                            ),
                          if (state.mylist.any(
                              (item) => item.category == _selectedCategory))
                            const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: Color(0xFFD4D4D4),
                                      height: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Text("OR"),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      color: Color(0xFFD4D4D4),
                                      height: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const Text("Response name*",
                              style: TextStyle(
                                  color: Color(
                                    0xFF151515,
                                  ),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                          TextFormField(
                            controller: _newSubCategory,
                            decoration: const InputDecoration(
                              hintText:
                                  "Enter title of this response for easy recall",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: Color(0xFFD4D4D4)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: Color(0xFFD4D4D4)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                                borderSide:
                                    BorderSide(color: Color(0xFFD4D4D4)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                  ],
                ],
              ),
            );
          }
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF73767B),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: BlocBuilder<MylistBloc, MylistState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor:
                      const Color(0xFF1E7BC8).withOpacity(0.5),
                  backgroundColor: const Color(0xFF1E7BC8),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: _selectedCategoryIndex != null &&
                        _newSubCategory.text.isNotEmpty
                    ? () {
                        context.read<MylistBloc>().add(InsertMylist(
                            _selectedCategory,
                            _newSubCategory.text,
                            widget.answer));

                        final selectedSubCategoryIndex =
                            _selectedSubCategory != null
                                ? state.mylist
                                    .where((item) =>
                                        item.category == _selectedCategory)
                                    .map((item) => item.subcategory)
                                    .toList()
                                    .indexOf(_selectedSubCategory!)
                                : null;
                        context.go('/KrofileAI/mylist', extra: {
                          'selectedCategoryIndex': _selectedCategoryIndex,
                          'selectedSubCategoryIndex': selectedSubCategoryIndex,
                          'newSubCategory': _newSubCategory.text,
                        });
                        context.pop();
                      }
                    : null,
                child: const Text(
                  "Create",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
