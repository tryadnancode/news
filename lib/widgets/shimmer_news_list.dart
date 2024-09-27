import 'package:flutter/material.dart';

class ShimmerNewsList extends StatelessWidget {
  const ShimmerNewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 15,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 15,
                    width: double.infinity,
                    color: Colors.grey[300],
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
