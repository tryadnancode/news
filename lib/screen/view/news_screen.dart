// import 'dart:async';
// import 'package:circular_graph/api/news_response.dart';
// import 'package:circular_graph/api/retrofit_helper.dart';
// import 'package:circular_graph/widgets/shimmer_news_list.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../widgets/category_menu.dart';
// import '../../widgets/internet_dialog.dart';
// import '../../widgets/news_details_dialog.dart';
// import '../../widgets/news_list.dart';
//
// class NewsScreen extends StatefulWidget {
//   const NewsScreen({super.key});
//
//   @override
//   _NewsScreenState createState() => _NewsScreenState();
// }
//
// class _NewsScreenState extends State<NewsScreen> {
//   List<Articles> articles = [];
//   bool isLoading = true;
//   String errorMessage = "";
//   String connectivityStatus = "Checking connectivity...";
//   StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;
//   bool _isFirstTime = true;  // Flag to prevent double SnackBar
//
//   @override
//   void initState() {
//     super.initState();
//     _checkConnectivityAndFetchNews();
//     _listenToConnectivityChanges();
//   }
//
//   @override
//   void dispose() {
//     // Cancel connectivity subscription to avoid memory leaks
//     connectivitySubscription?.cancel();
//     super.dispose();
//   }
//
//   // Check connectivity and fetch news
//   Future<void> _checkConnectivityAndFetchNews() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     setState(() {
//       connectivityStatus = (connectivityResult == ConnectivityResult.none)
//           ? 'Device is Offline'
//           : 'Device is Online';
//     });
//
//     if (_isFirstTime) {
//       // Show SnackBar only the first time and set flag to false
//       _isFirstTime = false;
//     } else {
//       // Show SnackBar after the first-time check
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(connectivityStatus),
//           duration: const Duration(seconds: 2),
//           backgroundColor: connectivityResult == ConnectivityResult.none ? Colors.red : Colors.green,
//         ),
//       );
//     }
//
//     if (connectivityResult != ConnectivityResult.none) {
//       fetchNews();
//     }
//   }
//
//   // Listen for connectivity changes
//   void _listenToConnectivityChanges() {
//     connectivitySubscription = Connectivity()
//         .onConnectivityChanged
//         .listen((List<ConnectivityResult> results) {
//       ConnectivityResult result =
//       results.isNotEmpty ? results.first : ConnectivityResult.none;
//       setState(() {
//         connectivityStatus = (result == ConnectivityResult.none)
//             ? 'Device is Offline'
//             : 'Device is Online';
//       });
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(connectivityStatus),
//           backgroundColor: result == ConnectivityResult.none ? Colors.red : Colors.green,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//
//       if (result != ConnectivityResult.none) {
//         fetchNews();
//       }
//     });
//   }
//
//   Future<void> fetchNews() async {
//     try {
//       final apiServices = RetrofitHelper().getClient();
//       final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
//       final String yesterday = DateFormat('yyyy-MM-dd')
//           .format(DateTime.now().subtract(const Duration(days: 1)));
//       final response = await apiServices.getNews(
//         "apple",
//         yesterday,
//         today,
//         "popularity",
//         "fba491f8e32043d5b09afe69661f8dc9",
//       );
//       print("API Response: ${response.toJson()}");
//       setState(() {
//         articles = response.articles ?? [];
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching news: $e");
//       setState(() {
//         isLoading = false;
//         errorMessage = "Failed to fetch news. Please try again later.";
//         //_showNoInternetDialog(); // Show dialog if news fetch fails
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("News"),
//         actions: [
//           CategoryMenu.getMenu(context),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: _checkConnectivityAndFetchNews,
//         child: Column(
//           children: [
//             if (isLoading)
//                // Expanded(child: ListView.builder(
//                //     itemCount: 5,
//                //     itemBuilder: (context, index){
//                //       return const ShimmerNewsList();
//                //     }))
//               const Center(child: CircularProgressIndicator())
//             else if (articles.isNotEmpty &&
//                 articles[0].urlToImage != null &&
//                 articles[0].urlToImage!.isNotEmpty)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 200,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: articles[0].urlToImage != null && articles[0].urlToImage!.isNotEmpty
//                           ? NetworkImage(articles[0].urlToImage!)  // Use article image
//                           : const AssetImage('assets/images/img.png'),
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: BorderRadius.circular(10),
//                     color: Colors.blueAccent,
//                   ),
//                 ),
//               )
//             else if (errorMessage.isNotEmpty)
//               Center(
//                 child: Text(
//                   errorMessage,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               )
//             else
//               const Center(child: Text("No articles available")),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: articles.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   final article = articles[index];
//                   return GestureDetector(
//                     onTap: () {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return NewsDetailsDialog(article: article);
//                         },
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                       child: NewsList(
//                         article: Articles(
//                           title: article.title ?? "No Title Available",
//                           description: article.description ?? "No Description Available",
//                           url: article.url ?? "",
//                           urlToImage: article.urlToImage ?? "",
//                           publishedAt: article.publishedAt ?? "",
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//   //Show no internet dialog
//   // void _showNoInternetDialog() {
//   //   showDialog(
//   //     context: context,
//   //     barrierDismissible: false,
//   //     builder: (context) {
//   //       return InternetDialog(
//   //         onRetry: _checkConnectivityAndFetchNews,
//   //       );
//   //     },
//   //   );
//   // }
// }
import 'dart:async';
import 'package:circular_graph/api/news_response.dart';
import 'package:circular_graph/api/retrofit_helper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/category_menu.dart';
import '../../widgets/news_details_dialog.dart';
import '../../widgets/all_news_tab.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with SingleTickerProviderStateMixin {
  List<Articles> articles = [];
  bool isLoading = true;
  String errorMessage = "";
  String connectivityStatus = "Checking connectivity...";
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;
  bool _isFirstTime = true;  // Flag to prevent double SnackBar

  @override
  void initState() {
    super.initState();
    _checkConnectivityAndFetchNews();
    _listenToConnectivityChanges();
  }

  @override
  void dispose() {
    // Cancel connectivity subscription to avoid memory leaks
    connectivitySubscription?.cancel();
    super.dispose();
  }

  // Check connectivity and fetch news
  Future<void> _checkConnectivityAndFetchNews() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      connectivityStatus = (connectivityResult == ConnectivityResult.none)
          ? 'Device is Offline'
          : 'Device is Online';
    });

    if (_isFirstTime) {
      _isFirstTime = false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(connectivityStatus),
          duration: const Duration(seconds: 2),
          backgroundColor: connectivityResult == ConnectivityResult.none ? Colors.red : Colors.green,
        ),
      );
    }

    if (connectivityResult != ConnectivityResult.none) {
      fetchNews();
    }
  }

  // Listen for connectivity changes
  void _listenToConnectivityChanges() {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      ConnectivityResult result =
      results.isNotEmpty ? results.first : ConnectivityResult.none;
      setState(() {
        connectivityStatus = (result == ConnectivityResult.none)
            ? 'Device is Offline'
            : 'Device is Online';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(connectivityStatus),
          backgroundColor: result == ConnectivityResult.none ? Colors.red : Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );

      if (result != ConnectivityResult.none) {
        fetchNews();
      }
    });
  }

  Future<void> fetchNews() async {
    setState(() {
      isLoading = true;
    });

    try {
      final apiServices = RetrofitHelper().getClient();
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
      print("API Response: ${response.toJson()}");
      setState(() {
        articles = response.articles ?? [];
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching news: $e");
      setState(() {
        isLoading = false;
        errorMessage = "Failed to fetch news. Please try again later.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("News"),
          actions: [
            CategoryMenu.getMenu(context),
          ],

          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: Container(
              padding: EdgeInsets.zero, // Remove any padding
              child: const TabBar(
                isScrollable: false, // Do not allow scrolling
                labelPadding: EdgeInsets.zero, // Remove label padding
                tabs: [
                  Tab(text: 'AllNews', icon: Icon(Icons.newspaper)),
                  Tab(text: 'Political', icon: Icon(Icons.article)),
                  Tab(text: 'Drama', icon: Icon(Icons.monitor_rounded)),
                  Tab(text: 'Sports', icon: Icon(Icons.sports)),
                  Tab(text: 'Tech', icon: Icon(Icons.engineering)),
                ],
              ),
            ),
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.red),
          ),
        )
            : TabBarView(
          children: [
            AllNewsTab(
              articles: articles,
              onRefresh: fetchNews, // Pass refresh function
            ),

            // Show articles in the first tab
            const Center(child: Text('Daily News')), // Placeholder for second tab
            const Center(child: Text('Entertainment')), // Placeholder for third tab
            const Center(child: Text('Sports')), // Placeholder for fourth tab
            const Center(child: Text('Tech')), // Placeholder for fifth tab
          ],
        ),
      ),
    );
  }

}


