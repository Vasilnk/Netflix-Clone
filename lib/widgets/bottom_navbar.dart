import 'package:flutter/material.dart';
import 'package:netflix/screens/home.dart';
import 'package:netflix/screens/hot_and_new.dart';
import 'package:netflix/screens/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: Container(
            height: 70,
            child: const TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.home),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(Icons.search),
                  text: 'Search',
                ),
                Tab(
                  icon: Icon(Icons.photo_library_outlined),
                  text: 'New & Hot',
                ),
              ],
              labelColor: Colors.white,
              unselectedLabelColor: Color(0xff999999),
            ),
          ),
          body: const TabBarView(
              children: [HomePage(), SearchMovies(), HotAndNew()]),
        ));
  }
}
