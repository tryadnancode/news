// import 'package:flutter/material.dart';
//
// class CategoryMenu {
//   static List<String> categories = [
//     'Daily News',
//     'Entertainment',
//     'Sports',
//     'Electronics'
//   ];
//
//   static PopupMenuButton<String> getMenu(BuildContext context) {
//     return PopupMenuButton<String>(icon: const Icon(Icons.category),
//       onSelected: (String value) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Selected: $value')),);
//       }, itemBuilder:(BuildContext context){
//       return categories.map((String category){
//         return PopupMenuItem<String>(
//           value: category,
//           child: Text(category),
//         );
//       }).toList();
//       },);
//
//   }
// }
//



import 'package:flutter/material.dart';

class CategoryMenu extends StatefulWidget {
  const CategoryMenu({super.key});

  @override
  _CategoryMenuState createState() => _CategoryMenuState();

  // Static method to get the menu, passing the controller for animation
  static PopupMenuButton<String> getMenu(BuildContext context, AnimationController controller) {
    List<String> categories = [
      'Daily News',
      'Entertainment',
      'Sports',
      'Electronics'
    ];

    return PopupMenuButton<String>(
      icon: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: controller.value * 2.0 * 3.141592653589793238, // Full circle rotation
            child: const Icon(Icons.sports_baseball),
          );
        },
      ),
      onSelected: (String value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Selected: $value')),
        );
      },
      itemBuilder: (BuildContext context) {
        return categories.map((String category) {
          return PopupMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList();
      },
    );
  }
}

class _CategoryMenuState extends State<CategoryMenu> with SingleTickerProviderStateMixin {
  // Define an AnimationController
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller to rotate the icon
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Duration for a complete rotation
      vsync: this,
    )..repeat(); // Continuously repeat the animation
  }

  @override
  void dispose() {
    // Dispose of the controller to free resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Menu'),
        actions: [
          // Use the getMenu method to display the rotating menu in the AppBar
          CategoryMenu.getMenu(context, _controller),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Press the category icon in the AppBar'),
            const SizedBox(height: 20),
            // Use the same getMenu method to display the rotating menu in the body
            CategoryMenu.getMenu(context, _controller),
          ],
        ),
      ),
    );
  }
}

