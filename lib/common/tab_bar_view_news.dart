import 'package:circular_graph/view/screen/tabview/all_news_tab.dart';
import 'package:circular_graph/view/screen/tabview/drama_tab.dart';
import 'package:circular_graph/view/screen/tabview/political_tab.dart';
import 'package:circular_graph/view/screen/tabview/sports_tab.dart';
import 'package:circular_graph/view/screen/tabview/tech_tab.dart';
import 'package:circular_graph/viewmodel/news_view_model.dart';
import 'package:flutter/material.dart';

class TabBarViewNews extends StatelessWidget {
  const TabBarViewNews({
    super.key,
    required this.newsViewModel,
  });

  final NewsViewModel newsViewModel;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        // All News Tab
        newsViewModel.isLoadingAllNews
            ? const Center(child: CircularProgressIndicator())
            : AllNewsTab(
          articles: newsViewModel.allNewsArticles, // Use allNewsArticles for AllNews tab
          onRefresh: newsViewModel.fetchAllNews, // Pass the refresh function
        ),
        // Political News Tab
        newsViewModel.isLoadingPolitical
            ? FutureBuilder<void>(
          future: newsViewModel.fetchPoliticalNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return PoliticalTab(
                articles: newsViewModel.politicalArticles,
                onRefresh: newsViewModel.fetchPoliticalNews,
              );
            }
          },
        )
            : PoliticalTab(
          articles: newsViewModel.politicalArticles,
          onRefresh: newsViewModel.fetchPoliticalNews,
        ),
        // Drama News Tab
        newsViewModel.isLoadingDrama
            ? FutureBuilder<void>(
          future: newsViewModel.fetchDramaNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return DramaTab(
                articles: newsViewModel.dramaArticles,
                onRefresh: newsViewModel.fetchDramaNews,
              );
            }
          },
        )
            : DramaTab(
          articles: newsViewModel.dramaArticles,
          onRefresh: newsViewModel.fetchDramaNews,
        ),
        // Sports News Tab
        newsViewModel.isLoadingSports
            ? FutureBuilder<void>(
          future: newsViewModel.fetchSportsNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return SportsTab(
                articles: newsViewModel.sportsArticles,
                onRefresh: newsViewModel.fetchSportsNews,
              );
            }
          },
        )
            : SportsTab(
          articles: newsViewModel.sportsArticles,
          onRefresh: newsViewModel.fetchSportsNews,
        ),
        // Tech News Tab
        newsViewModel.isLoadingTech
            ? FutureBuilder<void>(
          future: newsViewModel.fetchTechNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return TechTab(
                articles: newsViewModel.techArticles,
                onRefresh: newsViewModel.fetchTechNews,
              );
            }
          },
        )
            : TechTab(
          articles: newsViewModel.techArticles,
          onRefresh: newsViewModel.fetchTechNews,
        ),
      ],
    );
  }
}