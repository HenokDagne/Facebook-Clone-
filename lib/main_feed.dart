import 'package:flutter/material.dart';

class NewFeedSection extends StatelessWidget {
  const NewFeedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      scrollDirection: Axis.vertical,
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
            color: Colors.yellow[100],
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 4),
              bottom: BorderSide(color: Color(0xFFE5E6E9)
, width: 4),
            ),
          ),
        ),
        
        // Placeholder for additional posts
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 52, 17, 17),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
