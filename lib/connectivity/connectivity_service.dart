import 'package:circular_graph/screens.dart';


class ConnectivityService {
  String connectivityStatus = "Checking connectivity...";
  StreamSubscription<List<ConnectivityResult>>? connectivitySubscription;

  Future<String> checkConnectivityStatus() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return (connectivityResult == ConnectivityResult.none)
        ? 'Device is Offline'
        : 'Device is Online';
  }

  // Listen for connectivity changes
  void listenToConnectivityChanges(
      BuildContext context, Function(ConnectivityResult) onConnectivityChange) {
    connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      ConnectivityResult result =
      results.isNotEmpty ? results.first : ConnectivityResult.none;
      onConnectivityChange(result);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result == ConnectivityResult.none
                ? 'Device is Offline'
                : 'Device is Online',
          ),
          backgroundColor:
          result == ConnectivityResult.none ? Colors.red : Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void dispose() {
    // Cancel connectivity subscription to avoid memory leaks
    connectivitySubscription?.cancel();
  }
}
