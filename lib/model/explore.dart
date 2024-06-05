class ExploreCategory {
  final String name;
  final List<Subcategory> subcategories;

  ExploreCategory({required this.name, required this.subcategories});

  factory ExploreCategory.fromJson(Map<String, dynamic> json) {
    var list = json['subcategories'] as List;
    List<Subcategory> subcategoryList =
        list.map((i) => Subcategory.fromJson(i)).toList();

    return ExploreCategory(
      name: json['name'],
      subcategories: subcategoryList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subcategories': subcategories.map((i) => i.toJson()).toList(),
    };
  }
}

class Subcategory {
  final String name;
  final List<String> items;

  Subcategory({required this.name, required this.items});

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    var itemList = json['items'] as List;
    List<String> itemsList = itemList.map((i) => i.toString()).toList();

    return Subcategory(
      name: json['name'],
      items: itemsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'items': items,
    };
  }
}
