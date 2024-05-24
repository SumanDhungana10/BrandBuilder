class Category {
  final String name;
  final List<SubCategory> subcategories;

  Category({required this.name, required this.subcategories});

  factory Category.fromJson(Map<String, dynamic> json) {
    var subcategoriesJson = json['subcategory'] as List;
    List<SubCategory> subcategoriesList =
        subcategoriesJson.map((i) => SubCategory.fromJson(i)).toList();

    return Category(
      name: json['name'],
      subcategories: subcategoriesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subcategory': subcategories.map((sub) => sub.toJson()).toList(),
    };
  }
}

class SubCategory {
  final String name;
  final List<String> responses;

  SubCategory({required this.name, required this.responses});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    var responsesJson = json['response'] as List;
    List<String> responsesList =
        responsesJson.map((i) => i.toString()).toList();

    return SubCategory(
      name: json['name'],
      responses: responsesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'response': responses,
    };
  }
}
