class AppError implements Exception{
  final String message;
  final String code;

  AppError({required this.message, required this.code});

  @override
  String toString(){
    return "AppError: $message (code $code)";
  }
}

class NetworkError extends AppError{
  NetworkError(String message) : super(message: message, code: "network error");
}