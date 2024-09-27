import 'package:flutter/material.dart';
import 'package:circular_graph/api/news_response.dart';
import 'package:circular_graph/widgets/news_list.dart';
import 'news_details_dialog.dart';

class AllNewsTab extends StatelessWidget {
  final List<Articles> articles;
  final Future<void> Function() onRefresh;  // Function to refresh news

  const AllNewsTab({super.key, required this.articles, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,  // Attach the refresh function
      child: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (BuildContext context, int index) {
          final article = articles[index];
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return NewsDetailsDialog(article: article);
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: NewsList(
                article: Articles(
                  title: article.title ?? "No Title Available",
                  description: article.description ?? "No Description Available",
                  url: article.url ?? "",
                  urlToImage: article.urlToImage ?? "",
                  publishedAt: article.publishedAt ?? "",
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
