import 'package:ansicolor/ansicolor.dart';
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

import 'api_services.dart';

class RetrofitHelper{
 static final Dio dio = Dio();

 static ApiServices getClient(){
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
    dio.options.headers['Content-Type'] = 'application/json';
    return ApiServices(dio);
  }
}