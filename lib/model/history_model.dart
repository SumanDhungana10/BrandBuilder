class HistoryItem {
  final int id;
  final String email;
  final String question;
  final String answer;

  HistoryItem({
    required this.id,
    required this.email,
    required this.question,
    required this.answer,
  });

  // Factory method to create a HistoryItem from JSON
  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json[0] as int,
      email: json[1] as String,
      question: json[2] as String,
      answer: json[3] as String,
    );
  }

  // Method to convert a HistoryItem to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'question': question,
      'answer': answer,
    };
  }
}

// Parsing the JSON data to a List of HistoryItem
List<HistoryItem> parseHistory(List<dynamic> json) {
  return json.map((item) => HistoryItem.fromJson(item)).toList();
}
