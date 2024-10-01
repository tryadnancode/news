import 'package:flutter/material.dart';
class TabBarNews extends StatelessWidget {
  const TabBarNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const
    TabBar(
      isScrollable: false, // Do not allow scrolling
      labelPadding: EdgeInsets.zero, // Remove label padding
      tabs: [
        Tab(text: 'AllNews', icon: Icon(Icons.newspaper)),
        Tab(text: 'Political', icon: Icon(Icons.article)),
        Tab(text: 'Drama', icon: Icon(Icons.monitor_rounded)),
        Tab(text: 'Sports', icon: Icon(Icons.sports)),
        Tab(text: 'Tech', icon: Icon(Icons.engineering)),
      ],
    );
  }
}