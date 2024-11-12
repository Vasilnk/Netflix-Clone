import 'package:flutter/material.dart';
import 'package:netflix/widgets/coming_soon.dart';
import 'package:netflix/widgets/everyone_watching.dart';

class HotAndNew extends StatefulWidget {
  const HotAndNew({super.key});

  @override
  State<HotAndNew> createState() => _HotAndNewState();
}

class _HotAndNewState extends State<HotAndNew> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "New & Hot",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          actions: const [
            Icon(
              Icons.download,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.search,
              color: Colors.white,
            ),
            SizedBox(
              width: 20,
            ),
          ],
          bottom: TabBar(
              isScrollable: false,
              dividerColor: Colors.black,
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              labelColor: Colors.black,
              labelStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              tabs: [
                const Tab(
                  text: " 🍿 Coming Soon  ",
                ),
                const Tab(
                  text: " 🔥 EveryOne's watching  ",
                )
              ]),
        ),
        body: const TabBarView(
          children: [
            ComingSoon(),
            EveryoneWatchingWidget(), // Placeholder widget
          ],
        ),
      ),
    );
  }
}
