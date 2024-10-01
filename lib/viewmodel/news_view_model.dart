import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import '../model/api/news_response.dart';
import '../model/api/retrofit_helper.dart';

class NewsViewModel extends ChangeNotifier {
  // Separate articles for each category
  final apiServices = RetrofitHelper.getClient();
  List<Articles> allNewsArticles = [];
  List<Articles> politicalArticles = [];
  List<Articles> dramaArticles = [];
  List<Articles> sportsArticles = [];
  List<Articles> techArticles = [];

  // Loading state for each tab
  bool isLoadingAllNews = true;
  bool isLoadingPolitical = true;
  bool isLoadingDrama = true;
  bool isLoadingSports = true;
  bool isLoadingTech = true;

  bool isFirstLoadAllNews = true;
  bool isFirstLoadPolitical = true;
  bool isFirstLoadDrama = true;
  bool isFirstLoadSports = true;
  bool isFirstLoadTech = true;

  String errorMessage = "";

  // Fetch All News
  Future<void> fetchAllNews() async {
    isLoadingAllNews = true;
    notifyListeners();

    try {

      final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final String yesterday = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(const Duration(days: 1)));
      final response = await apiServices.getNews(
        "apple",
        yesterday,
        today,
        "popularity",
        "fba491f8e32043d5b09afe69661f8dc9",
      );
      allNewsArticles = response.articles ?? [];
      isLoadingAllNews = false;
      isFirstLoadAllNews = false;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching news: $e");
      }
      isLoadingAllNews = false;
      errorMessage = "Failed to fetch news. Please try again later.";
    }
    notifyListeners();
  }

  // Fetch Political News
  Future<void> fetchPoliticalNews() async {
    isLoadingPolitical = true;
    notifyListeners();

    try {

      //final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final String yesterday = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().subtract(const Duration(days: 1)));

      final response = await apiServices.getTeslaNews(
        "tesla",
        yesterday,
        "popularity",
        "fba491f8e32043d5b09afe69661f8dc9",
      );
      politicalArticles = response.articles ?? [];
      isLoadingPolitical = false;
      isFirstLoadPolitical = false;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching political news: $e");
      }
      isLoadingPolitical = false;
      errorMessage = "Failed to fetch news. Please try again later.";
    }
    notifyListeners();
  }

  // Fetch Drama News
  Future<void> fetchDramaNews() async {
    isLoadingDrama = true;
    notifyListeners();

    try {

      final response = await apiServices.getWSJNews(
        "wsj.com",
        "fba491f8e32043d5b09afe69661f8dc9",
      );
      dramaArticles = response.articles ?? [];
      isLoadingDrama = false;
      isFirstLoadDrama = false;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching drama news: $e");
      }
      isLoadingDrama = false;
      errorMessage = "Failed to fetch news. Please try again later.";
    }
    notifyListeners();
  }

  // Fetch Sports News
  Future<void> fetchSportsNews() async {
    isLoadingSports = true;
    notifyListeners();

    try {

      final response = await apiServices.getBusinessTopHeadlines(
        "us",
        "sports",
        "fba491f8e32043d5b09afe69661f8dc9",
      );
      sportsArticles = response.articles ?? [];
      isLoadingSports = false;
      isFirstLoadSports = false;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching sports news: $e");
      }
      isLoadingSports = false;
      errorMessage = "Failed to fetch news. Please try again later.";
    }
    notifyListeners();
  }

  // Fetch Tech News
  Future<void> fetchTechNews() async {
    isLoadingTech = true;
    notifyListeners();

    try {

      final response = await apiServices.getTechCrunchTopHeadlines(
        "techCrunch",
        "fba491f8e32043d5b09afe69661f8dc9",
      );
      techArticles = response.articles ?? [];
      isLoadingTech = false;
      isFirstLoadTech = false;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching tech news: $e");
      }
      isLoadingTech = false;
      errorMessage = "Failed to fetch news. Please try again later.";
    }
    notifyListeners();
  }
}
