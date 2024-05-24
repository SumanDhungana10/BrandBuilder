import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krofile_ai/cubit/mylist/mylist_cubit.dart';

class MyList extends StatefulWidget {
  const MyList({super.key});

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: BlocBuilder<MylistCubit, MylistState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          } else {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return ExpansionTile(
                  title: Text(category.name),
                  children: category.subcategories.map((subcategory) {
                    return ListTile(
                      title: Text(subcategory.name),
                      subtitle: subcategory.responses.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: subcategory.responses
                                  .map((response) => Text(response))
                                  .toList(),
                            )
                          : const Text('No responses'),
                    );
                  }).toList(),
                );
              },
            );
          }
        },
      ),
    );
  }
}
