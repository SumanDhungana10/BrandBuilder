import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:krofile_ai/cubit/mylist/mylist_cubit.dart';
import 'package:krofile_ai/model/mylist.dart';
import 'package:krofile_ai/screen/mylist.dart';

class AddToMyList extends StatefulWidget {
  const AddToMyList({super.key, required this.answer});
  final String answer;

  @override
  State<AddToMyList> createState() => _AddToMyListState();
}

class _AddToMyListState extends State<AddToMyList> {
  final TextEditingController _newSubCategory = TextEditingController();
  String _selectedCategory = "";
  SubCategory? _selectedSubCategory;
  int?
      _selectedCategoryIndex; // State variable to store selected category index

  @override
  void dispose() {
    _newSubCategory.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
      content: BlocBuilder<MylistCubit, MylistState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          } else {
            final categories = state.categories;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < categories.length; i++) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(categories[i].name),
                      Radio(
                        value: categories[i].name,
                        groupValue: _selectedCategory,
                        activeColor: const Color(0xFF18C554),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value.toString();
                            _selectedSubCategory = null; // Reset subcategory
                            _selectedCategoryIndex =
                                i; // Store selected category index
                          });
                        },
                      ),
                    ],
                  ),
                  if (_selectedCategory == categories[i].name)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFD4D4D4),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButton<SubCategory>(
                            isExpanded: true,
                            focusColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            underline: Container(),
                            icon: SvgPicture.asset(
                              "assets/images/fe_arrow-right.svg",
                            ),
                            value: categories[i]
                                    .subcategories
                                    .contains(_selectedSubCategory)
                                ? _selectedSubCategory
                                : null,
                            hint: const Text("--Select response name--*"),
                            onChanged: (value) {
                              setState(() {
                                _selectedSubCategory = value;
                              });
                            },
                            items:
                                categories[i].subcategories.map((subCategory) {
                              return DropdownMenuItem(
                                value: subCategory,
                                child: Text(subCategory.name),
                              );
                            }).toList(),
                          ),
                        ),
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
                                padding: EdgeInsets.symmetric(horizontal: 8),
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
                        TextFormField(
                          controller: _newSubCategory,
                          decoration: const InputDecoration(
                            hintText: "Add new response",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              borderSide: BorderSide(
                                color: Color(0xFFD4D4D4),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              borderSide: BorderSide(
                                color: Color(0xFFD4D4D4),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              borderSide: BorderSide(
                                color: Color(0xFFD4D4D4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ],
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
          child: BlocBuilder<MylistCubit, MylistState>(
            builder: (context, state) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF18C554),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: _selectedCategoryIndex != null
                    ? () {
                        context.read<MylistCubit>().addSubCategory(
                              _selectedCategoryIndex!,
                              _newSubCategory.text.isNotEmpty
                                  ? _newSubCategory.text
                                  : _selectedSubCategory!.name,
                              widget.answer,
                            );

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyList(
                                      selectedCategoryIndex:
                                          _selectedCategoryIndex!,
                                      selectedSubCategoryIndex:
                                          _selectedSubCategory != null
                                              ? state
                                                  .categories[
                                                      _selectedCategoryIndex!]
                                                  .subcategories
                                                  .indexOf(
                                                      _selectedSubCategory!)
                                              : null,
                                    )));
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
