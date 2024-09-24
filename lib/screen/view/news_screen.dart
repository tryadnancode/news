// import 'package:circular_graph/widgets/news_list.dart';
// import 'package:flutter/material.dart';
//
// import '../../widgets/category_menu.dart';
//
// class NewsScreen extends StatelessWidget {
//   const NewsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("News"),
//         actions: [
//          // IconButton(onPressed: () {}, icon: const Icon(Icons.category))
//           CategoryMenu.getMenu(context), // Use the menu here
//
//         ],
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 200,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   image: const DecorationImage(image: AssetImage("")),
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.blueAccent),
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//                 itemCount: 5,
//                 itemBuilder: (BuildContext context, int index) {
//                   return const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                       child: NewsList());
//                 }),
//           )
//         ],
//       ),
//     );
//   }
// }
//

import 'package:circular_graph/api/news_response.dart';
import 'package:circular_graph/api/retrofit_helper.dart';
import 'package:circular_graph/widgets/internet_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../widgets/category_menu.dart';
import '../../widgets/news_list.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Articles> articles = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    //fetchNews();
    _checkConnectivityAndFetchNews();
  }

  Future<void> _checkConnectivityAndFetchNews() async {
    var connectivityResult = Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _showNoInternetDialog();
    } else {
      fetchNews();
    }
  }

  Future<void> fetchNews() async {
    try {
      // final apiServices = RetrofitHelper().getClient();
      // final response = await apiServices.getNews(
      //   "apple",
      //   "2024-09-23",
      //   "2024-09-23",
      //   "popularity",
      //   "fba491f8e32043d5b09afe69661f8dc9",
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        actions: [
          CategoryMenu.getMenu(context),
        ],
      ),
      body: Column(
        children: [
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (articles.isNotEmpty &&
              articles[2].urlToImage != null &&
              articles[2].urlToImage!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(articles[2].urlToImage ?? ""),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueAccent,
                ),
              ),
            )
          else
            const Center(child: Text("No articles available")),
          if (errorMessage.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: articles.length,
              itemBuilder: (BuildContext context, int index) {
                final article = articles[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: NewsList(
                    article: Articles(
                      title: article.title ?? "No Title Available",
                      // Default value
                      description:
                          article.description ?? "No Description Available",
                      // Default value
                      url: article.url ?? "",
                      // Provide a default empty string
                      urlToImage: article.urlToImage ?? "",
                      // Provide a default empty string
                      publishedAt: article.publishedAt ??
                          "", // Provide a default empty string
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showNoInternetDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return InternetDialog(onRetry: _checkConnectivityAndFetchNews);
        });
  }
}
