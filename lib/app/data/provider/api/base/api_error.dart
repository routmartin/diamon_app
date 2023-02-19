import '../../../enums/enum_api_error_status.dart';
export '../../../enums/enum_api_error_status.dart';
export '../../../enums/enum_request_data_status.dart';
export '../../../../../utils/values/app_constants.dart';

class ApiError {
  final ApiErrorStatus apiErrorType;
  final ApiMessage apiMessage;
  ApiError(this.apiErrorType, this.apiMessage);
}

class ApiMessage {
  final int statusCode;
  final String message;

  ApiMessage({required this.statusCode, required this.message});
  factory ApiMessage.fromJson(Map<String, dynamic> json) {
    return ApiMessage(
      statusCode: json.containsKey("statusCode") ? json["statusCode"] : null,
      message: json.containsKey("message") ? json["message"] : null,
    );
  }
}
