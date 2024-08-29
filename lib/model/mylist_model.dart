class MyListItem {
  final int id;
  final String email;
  final String category;
  final String subcategory;
  final String content;

  MyListItem({
    required this.id,
    required this.email,
    required this.category,
    required this.subcategory,
    required this.content,
  });

  factory MyListItem.fromJson(List<dynamic> json) {
    return MyListItem(
      id: json[0],
      email: json[1],
      category: json[2],
      subcategory: json[3],
      content: json[4],
    );
  }
}

class MyListResponse {
  final String message;
  final List<MyListItem> data;

  MyListResponse({
    required this.message,
    required this.data,
  });

  factory MyListResponse.fromJson(Map<String, dynamic> json) {
    return MyListResponse(
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => MyListItem.fromJson(item))
          .toList(),
    );
  }
}
