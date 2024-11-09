import 'package:flutter/material.dart';

class NewAndHot extends StatelessWidget {
  const NewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New & Hot",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: [Icon(Icons.cast), Icon(Icons.cast)],
      ),
    );
  }
}
