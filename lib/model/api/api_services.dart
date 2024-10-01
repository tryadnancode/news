import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import 'news_response.dart';

part 'api_services.g.dart';

@RestApi(baseUrl: "https://newsapi.org/v2/")
abstract class ApiServices {
  factory ApiServices(Dio dio, {String baseUrl}) = _ApiServices;

  @GET('everything')
  Future<NewsResponse> getNews(
      @Query("q") String query,
      @Query("from") String from,
      @Query("to") String to,
      @Query("sortBy") String sortBy,
      @Query("apiKey") String apiKey,
      );

  @GET('everything')
  Future<NewsResponse> getTeslaNews(
      @Query("q") String query,
      @Query("from") String from,
      @Query("sortBy") String sortBy,
      @Query("apiKey") String apiKey,
      );

  @GET('top-headlines')
  Future<NewsResponse> getBusinessTopHeadlines(
      @Query("country") String country,
      @Query("category") String category,
      @Query("apiKey") String apiKey,
      );

  @GET('top-headlines')
  Future<NewsResponse> getTechCrunchTopHeadlines(
      @Query("sources") String sources,
      @Query("apiKey") String apiKey,
      );

  @GET('everything')
  Future<NewsResponse> getWSJNews(
      @Query("domains") String domains,
      @Query("apiKey") String apiKey,
      );
}
