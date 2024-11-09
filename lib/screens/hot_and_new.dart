import 'package:flutter/material.dart';

class HotAndNew extends StatefulWidget {
  const HotAndNew({super.key});

  @override
  State<HotAndNew> createState() => _HotAndNewState();
}

class _HotAndNewState extends State<HotAndNew> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'this is hot and new page',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
