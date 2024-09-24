// import 'package:flutter/material.dart';
//
// class CategoryMenu {
//   static const List<String> categories = [
//     'Daily News',
//     'Entertainment',
//     'Sports',
//     'Electronics',
//   ];
//
//   static PopupMenuButton<String> getMenu(BuildContext context) {
//     return PopupMenuButton<String>(
//       icon: const Icon(Icons.category),
//       onSelected: (String value) {
//         // Handle category selection
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Selected: $value')),
//         );
//       },
//       itemBuilder: (BuildContext context) {
//         return categories.map((String category) {
//           return PopupMenuItem<String>(
//             value: category,
//             child: Text(category),
//           );
//         }).toList();
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class CategoryMenu {
  static List<String> categories = [
    'Daily News',
    'Entertainment',
    'Sports',
    'Electronics'
  ];

  static PopupMenuButton<String> getMenu(BuildContext context) {
    return PopupMenuButton<String>(icon: const Icon(Icons.category),
      onSelected: (String value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected: $value')),);
      }, itemBuilder:(BuildContext context){
      return categories.map((String category){
        return PopupMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList();
      },);

  }
}