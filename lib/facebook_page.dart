import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'stories_page.dart';
import 'main_feed.dart';
import 'login_page.dart';
import 'people_page.dart';
import 'notification.dart';
import 'people_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class FacebookPage extends StatefulWidget {
  const FacebookPage({super.key});

  @override
  State<FacebookPage> createState() => _FacebookPageState();
}

class _FacebookPageState extends State<FacebookPage> {
  int _selectedTab = 0; // 0: home, 1: people, 2: notifications
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        toolbarTextStyle: const TextStyle(color: Colors.blueGrey),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 31, 101, 230),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        title: const Text('facebook'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, size: 32),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.menu, size: 32), onPressed: () {}),
          currentUser == null
              ? IconButton(
                  icon: const Icon(Icons.login, size: 32),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.logout, size: 32),
                  onPressed: () async {
                    await firebase_auth.FirebaseAuth.instance.signOut();
                    if (!mounted) return;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Logged out')));
                    setState(() {});
                  },
                ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Icon container (tab bar)
          Container(
            color: Colors.white,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    size: 30,
                    color: _selectedTab == 0 ? Colors.blue : Colors.blueGrey,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedTab = 0;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.people,
                    size: 30,
                    color: _selectedTab == 1 ? Colors.blue : Colors.blueGrey,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedTab = 1;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.facebookMessenger,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.video_collection,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.notifications,
                    size: 30,
                    color: _selectedTab == 2 ? Colors.blue : Colors.blueGrey,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedTab = 2;
                    });
                  },
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.shop,
                    color: Colors.blueGrey,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Search bar above StoriesSection
          if (_selectedTab == 0)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search news by title...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 12,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),

          // Section below the icon container
          Expanded(
            child: _selectedTab == 0
                ? Column(
                    children: [
                      const StoriesSection(),
                      Expanded(
                        child: NewFeedSection(searchQuery: _searchQuery),
                      ),
                    ],
                  )
                : _selectedTab == 1
                ? PeoplePage()
                : NotificationPage(),
          ),
        ],
      ),
    );
  }
}
