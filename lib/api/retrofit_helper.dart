import 'package:ansicolor/ansicolor.dart';
import 'package:circular_graph/api/api_services.dart';
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class RetrofitHelper{
  final Dio dio = Dio();
  RetrofitHelper(){
    // Add TalkerDioLogger interceptor
    dio.interceptors.add(TalkerDioLogger(
      // By default, this will log requests and responses
      settings:   TalkerDioLoggerSettings(
        printResponseData: true,
        printRequestData: true,  // Log request data
        printRequestHeaders: true, // Log request headers
        printResponseHeaders: true,
         requestPen: AnsiPen()..green(),  // Color logs for requests
         responsePen: AnsiPen()..blue(), // Log response headers
      ),
    ));
  }
  ApiServices getClient(){
    dio.options.headers['Content-Type'] = 'application/json';
    return ApiServices(dio);
  }
}