class IncognitoResponseModel {
  String response;

  IncognitoResponseModel({required this.response});

  factory IncognitoResponseModel.fromJson(Map<String, dynamic> json) {
    return IncognitoResponseModel(response: json['response']);
  }

  Map<String, dynamic> toJson() {
    return {
      'response': response,
    };
  }
}
