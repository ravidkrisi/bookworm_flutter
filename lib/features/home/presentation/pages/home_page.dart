import 'package:bookworm/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final String currUid;
  const HomePage({super.key, required this.currUid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // tabs
  late final Map<String, Map<String, dynamic>> tabs;

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    tabs = {
      'home': {'icon': Icon(FontAwesomeIcons.house), 'page': Text('home')},
      'profile': {
        'icon': Icon(FontAwesomeIcons.person),
        'page': ProfilePage(uid: widget.currUid),
      },
    };
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // SCAFFOLD
    return Scaffold(
      body:
      // TABS VIEW
      TabBarView(
        controller: _tabController,
        children:
            tabs.entries
                .map((entry) => (entry.value['page'] as Widget))
                .toList(),
      ),
      // BOTTOM NAVIGATION BAR
      bottomNavigationBar: TabBar(
        controller: _tabController,
        tabs:
            tabs.entries
                .map((entry) => Tab(icon: entry.value['icon']))
                .toList(),
      ),
    );
  }
}
