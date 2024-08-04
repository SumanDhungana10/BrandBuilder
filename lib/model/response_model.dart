class ResponseModel {
  String response;

  ResponseModel({required this.response});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      response: json['response'] 
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'response': response,
    };
  }
}
