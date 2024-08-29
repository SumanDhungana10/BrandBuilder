class QuickQuestionModel {
  final int id;
  final String username;
  final String question;
  final DateTime createdAt;
  

  QuickQuestionModel({
    required this.id,
    required this.username,
    required this.question,
    required this.createdAt,
  });

  // Factory constructor to create a QuickQuestionModel from JSON
  factory QuickQuestionModel.fromJson(Map<String, dynamic> json) {
    return QuickQuestionModel(
      id: json['id'],
      username: json['Username'],
      question: json['Question'],
      createdAt: DateTime.parse(json['CreatedAt']),
    );
  }

  // Method to convert QuickQuestionModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Username': username,
      'Question': question,
      'CreatedAt': createdAt.toIso8601String(),
    };
  }
}
