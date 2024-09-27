// import 'package:flutter/material.dart';
// import '../api/news_response.dart';
//
// class NewsList extends StatelessWidget {
//   final Articles article;
//
//   const NewsList({required this.article, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Container(
//               height: 100,
//               width: 100,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.grey[200],
//                 image: article.urlToImage != null && article.urlToImage!.isNotEmpty
//                     ? DecorationImage(
//                   image: NetworkImage(article.urlToImage??"Empty"),
//                   fit: BoxFit.cover,
//                 )
//                     : null,
//               ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     article.title ?? "Empty",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     article.description ?? "Empty",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.black54,
//                     ),
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//




// import 'package:flutter/material.dart';
// import '../api/news_response.dart';
//
// class NewsList extends StatelessWidget {
//   final Articles article;
//
//   const NewsList({required this.article, super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             Container(
//               height: 100,
//               width: 100,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5),
//                 color: Colors.grey[200],
//               ),
//               child:
//                   article.urlToImage != null && article.urlToImage!.isNotEmpty
//                       ? ClipRRect(
//                           borderRadius: BorderRadius.circular(5),
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               const CircularProgressIndicator(),
//                               // Show loading indicator by default
//                               Image.network(
//                                 article.urlToImage ?? "",
//                                 fit: BoxFit.cover,
//                                 height: 100,
//                                 width: 100,
//                                 loadingBuilder: (BuildContext context,
//                                     Widget child,
//                                     ImageChunkEvent? loadingProgress) {
//                                   if (loadingProgress == null) {
//                                     return child; // Image is fully loaded
//                                   } else {
//                                     return const Center(
//                                         child:
//                                             CircularProgressIndicator()); // While loading
//                                   }
//                                 },
//                                 errorBuilder: (context, error, stackTrace) {
//                                   return const Icon(Icons.broken_image,
//                                       size: 50, color: Colors.grey);
//                                 },
//                               ),
//                             ],
//                           ),
//                         )
//                       : const Center(
//                           child: Icon(Icons.broken_image,
//                               size: 50, color: Colors.grey),
//                         ),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     article.title ?? "Empty",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     article.description ?? "Empty",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.black54,
//                     ),
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';
import '../api/news_response.dart';

class NewsList extends StatefulWidget {
  final Articles article;

  const NewsList({required this.article, super.key});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  bool _isLoading = true;  // Tracks the loading state

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[200],
              ),
              child: widget.article.urlToImage != null && widget.article.urlToImage!.isNotEmpty
                  ? Image.network(
                widget.article.urlToImage ?? "",
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;  // Image is loaded, display it
                  } else {
                    // Show a loading indicator
                    return const Center(
                      child: CircularProgressIndicator(),  // Show loading indicator while image is loading
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image, size: 50, color: Colors.grey);  // Handle image load errors
                },
              )
                  : const Center(
                child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.article.title ?? "Empty",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.article.description ?? "Empty",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
