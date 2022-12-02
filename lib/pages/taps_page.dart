import 'package:flutter/material.dart';
import 'package:world_cup/pages/leader%20board/leader_board_page.dart';
import 'package:world_cup/pages/profile/profile_page.dart';
import 'package:world_cup/pages/rules/rules_page.dart';

import 'match page/home_page.dart';

class TapsPage extends StatefulWidget {
  const TapsPage({Key? key}) : super(key: key);

  @override
  State<TapsPage> createState() => _TapsPageState();
}

class _TapsPageState extends State<TapsPage> {
  List<Widget> pages = const [
    RulesPage(),
    HomePage(),
    Profile(),
    LeaderBoardPage(),
  ];
  int _index = 1;
  final pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageView,
      bottomNavigationBar: bottomBar(),
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: Theme.of(context).iconTheme.color,
      unselectedItemColor: Theme.of(context).iconTheme.color,
      elevation: 2,
      enableFeedback: true,
      onTap: (i) => setState(() {
        _index = i;
        pageController.animateToPage(
          i,
          duration: const Duration(microseconds: 500),
          curve: Curves.bounceInOut,
        );
      }),
      currentIndex: _index,
      items: const [
        BottomNavigationBarItem(
          label: 'Rules',
          activeIcon: Icon(Icons.info),
          icon: Icon(Icons.info_outline),
        ),
        BottomNavigationBarItem(
          label: 'home',
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home_outlined),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          activeIcon: Icon(Icons.person),
          icon: Icon(Icons.person_outline),
        ),
        BottomNavigationBarItem(
          label: 'Leaderboard',
          activeIcon: Icon(Icons.leaderboard),
          icon: Icon(Icons.leaderboard_outlined),
        ),
      ],
    );
  }

  //used to make screen slides
  PageView get _pageView {
    return PageView(
      controller: pageController,
      children: pages,
      onPageChanged: (index) => setState(
        () {
          //index used here to apply changing the page to the bottom navigation bar 'Icons and labels'
          _index = index;
        },
      ),
    );
  }
}
