class ErrorModel implements Exception {
  String? code;
  String? errorMessage;

  ErrorModel({this.code, this.errorMessage});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    code = json['Code'];
    errorMessage = json['ErrorMessage'];
  }

  ErrorModel.fromNull() {
    code = '500';
    errorMessage = 'Please check internet connection';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Code'] = code;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}

class ErrorAuthModel {
  String? error;
  String? error_description;

  ErrorAuthModel({this.error, this.error_description});

  ErrorAuthModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    error_description = json['error_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['error'] = error;
    data['error_description'] = error_description;
    return data;
  }
}
