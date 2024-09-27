// import 'package:circular_graph/api/news_response.dart';
// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class NewsDetailsDialog extends StatelessWidget {
//   final Articles article;
//
//   const NewsDetailsDialog({super.key, required this.article});
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(article.title ?? "No Title"),
//       content: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
//               Image.network(article.urlToImage!),
//             const SizedBox(height: 10),
//             Text(
//               article.description ?? "No Description Available",
//               style: const TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Published At: ${article.publishedAt ?? "Unknown Date"}",
//               style: const TextStyle(color: Colors.grey),
//             ),
//             const SizedBox(height: 10),
//             TextButton(
//                 onPressed: () async {
//                   final Uri url = Uri.parse("https://www.google.com/");
//                   print("Launching URL:"
//                       " $url");
//                   if (await canLaunchUrl(url)) {
//                     await launchUrl(url);
//                   } else {
//                     throw 'Could not launch $url';
//                   }
//                 },
//
//               child: const Text("Read Full Article"),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: const Text("Close"),
//         ),
//       ],
//     );
//   }
// }
//
import 'package:circular_graph/api/news_response.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsDialog extends StatelessWidget {
  final Articles article;

  const NewsDetailsDialog({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the image first if the URL is not empty
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              Image.network(article.urlToImage!),

            const SizedBox(height: 10),

            // Title of the article
            Text(
              article.title ?? "No Title",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // Article description
            Text(
              article.description ?? "No Description Available",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),

            // Published date
            Text(
              "Published At: ${article.publishedAt ?? "Unknown Date"}",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),

            // Button to open the article URL
            TextButton(
              onPressed: () async {
                final Uri url = Uri.parse(article.url ?? "https://www.google.com/");
                print("Launching URL: $url");

                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Could not launch the article URL."),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Read Full Article"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Close"),
        ),
      ],
    );
  }
}

