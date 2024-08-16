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

  factory HistoryItem.fromJson(List<dynamic> json) {
    return HistoryItem(
      id: json[0],
      email: json[1],
      question: json[2],
      answer: json[3],
    );
  }

  List<dynamic> toJson() {
    return [id, email, question, answer];
  }
}

class HistoryResponse {
  final List<HistoryItem> history;

  HistoryResponse({required this.history});

  factory HistoryResponse.fromJson(Map<String, dynamic> json) {
    var historyList = json['history'] as List;
    List<HistoryItem> historyItems =
        historyList.map((item) => HistoryItem.fromJson(item)).toList();
    return HistoryResponse(history: historyItems);
  }

  Map<String, dynamic> toJson() {
    return {
      'history': history.map((item) => item.toJson()).toList(),
    };
  }
}
