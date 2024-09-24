// import 'package:flutter/material.dart';
//
// class NewsList extends StatelessWidget {
//   const NewsList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.black12,
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 100,
//               width: 100,
//               decoration: BoxDecoration(
//                   image: const DecorationImage(
//                       image: AssetImage(""), fit: BoxFit.fill),
//                   borderRadius: BorderRadius.circular(5),
//                   color: Colors.black),
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(top: 12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("News headline"),
//                 Text("News description")
//               ],
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../api/news_response.dart';

class NewsList extends StatelessWidget {
  final Articles article;

  const NewsList({required this.article, super.key});

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
                image: article.urlToImage != null && article.urlToImage!.isNotEmpty
                    ? DecorationImage(
                  image: NetworkImage(article.urlToImage??"Empty"),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title ?? "Empty",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    article.description ?? "Empty",
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


