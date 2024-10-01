// import 'package:circular_graph/screens.dart';
//
// class NewsScreen extends StatefulWidget {
//   const NewsScreen({super.key});
//
//   @override
//   _NewsScreenState createState() => _NewsScreenState();
// }
//
// class _NewsScreenState extends State<NewsScreen> with SingleTickerProviderStateMixin {
//   final ConnectivityService _connectivityService = ConnectivityService(); // Initialize connectivity service
//   String connectivityStatus = "Checking connectivity..."; // Track connectivity status
//
//   @override
//   void initState() {
//     super.initState();
//     _checkConnectivityAndFetchNews();
//     _listenToConnectivityChanges();    // Listen for connectivity changes
//   }
//
//   // Fetch news initially based on connectivity status
//
//   Future<void> _checkConnectivityAndFetchNews() async {
//     final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
//     String status = await _connectivityService.checkConnectivityStatus();
//     setState(() {
//       connectivityStatus = status;
//     });
//     if (status == 'Device is Online') {
//       await newsViewModel.fetchAllNews(); // Fetch news if online
//     }
//   }
//
//   // Listen for connectivity changes and update the UI accordingly
//
//   void _listenToConnectivityChanges() {
//     _connectivityService.listenToConnectivityChanges(
//       context,
//           (ConnectivityResult result) {
//         setState(() {
//           connectivityStatus = (result == ConnectivityResult.none)
//               ? 'Device is Offline'
//               : 'Device is Online';
//         });
//
//         if (result != ConnectivityResult.none) {
//           final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
//           newsViewModel.fetchAllNews(); // Fetch news again if online
//         }
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     // Dispose the connectivity subscription
//     _connectivityService.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final newsViewModel = Provider.of<NewsViewModel>(context);
//
//     return DefaultTabController(
//       length: 5, // Number of tabs
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("News"), // Show connectivity status
//           actions: [
//             CategoryMenu.getMenu(context),
//           ],
//           bottom: PreferredSize(
//             preferredSize: const Size.fromHeight(56.0),
//             child: Container(
//               padding: EdgeInsets.zero, // Remove any padding
//               child: const TabBarNews(),
//             ),
//           ),
//         ),
//         body:
//         TabBarViewNews(newsViewModel: newsViewModel),
//       ),
//     );
//   }
// }
//
//
//
//
import 'package:flutter/material.dart';
import 'package:circular_graph/screens.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> with SingleTickerProviderStateMixin {
  final ConnectivityService _connectivityService = ConnectivityService(); // Initialize connectivity service
  String connectivityStatus = "Checking connectivity..."; // Track connectivity status

  late AnimationController _categoryMenuController; // Add AnimationController for CategoryMenu

  @override
  void initState() {
    super.initState();
    _checkConnectivityAndFetchNews();
    _listenToConnectivityChanges();

    // Initialize the AnimationController for the rotating CategoryMenu icon
    _categoryMenuController = AnimationController(
      duration: const Duration(seconds: 1), // Full rotation in 3 seconds
      vsync: this,
    )..repeat(); // Repeat indefinitely
  }

  @override
  void dispose() {
    // Dispose the connectivity subscription and animation controller
    _connectivityService.dispose();
    _categoryMenuController.dispose(); // Dispose the AnimationController
    super.dispose();
  }

  // Fetch news initially based on connectivity status
  Future<void> _checkConnectivityAndFetchNews() async {
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    String status = await _connectivityService.checkConnectivityStatus();
    setState(() {
      connectivityStatus = status;
    });
    if (status == 'Device is Online') {
      await newsViewModel.fetchAllNews(); // Fetch news if online
    }
  }

  // Listen for connectivity changes and update the UI accordingly
  void _listenToConnectivityChanges() {
    _connectivityService.listenToConnectivityChanges(
      context,
          (ConnectivityResult result) {
        setState(() {
          connectivityStatus = (result == ConnectivityResult.none)
              ? 'Device is Offline'
              : 'Device is Online';
        });

        if (result != ConnectivityResult.none) {
          final newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
          newsViewModel.fetchAllNews(); // Fetch news again if online
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context);

    return DefaultTabController(
      length: 5, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text("News"), // Show connectivity status
          actions: [
            // Use the rotating category menu in the AppBar
            CategoryMenu.getMenu(context, _categoryMenuController),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(56.0),
            child: Container(
              padding: EdgeInsets.zero, // Remove any padding
              child: const TabBarNews(),
            ),
          ),
        ),
        body: TabBarViewNews(newsViewModel: newsViewModel),
      ),
    );
  }
}
