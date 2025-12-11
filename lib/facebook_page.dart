import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'stories_page.dart';
import 'main_feed.dart';

class FacebookPage extends StatelessWidget {
  const FacebookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'facebook',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 31, 101, 230),
          ),
        ),
        //actions: <>{},
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, size: 32), // use Icon() widget
            onPressed: () {
              // Add your action here
              print("Search pressed");
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu, size: 32), // use Icon() widget
            onPressed: () {
              // Add your action here
              print("Menu pressed");
            },
          ),
        ],
      ),
      // ...existing code...
      // ...existing code...
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 50,

            //padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home, size: 30, color: Colors.blueGrey),
                  onPressed: () => {print("navigate to home page ")},
                ),
                IconButton(
                  icon: Icon(Icons.people, size: 30, color: Colors.blueGrey),
                  onPressed: () => {print("")},
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.facebookMessenger,
                    size: 30,
                    color: Colors.blueGrey,
                  ),
                  onPressed: () => {print("")},
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
                  icon: Icon(Icons.notifications),
                  color: Colors.blueGrey,
                  hoverColor: Colors.blue.withOpacity(0.12),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.shop,
                    color: Colors.blueGrey,
                  ), // or FontAwesomeIcons.store
                  onPressed: () {
                    // TODO: handle tap
                  },
                ),
              ],
            ),
          ),

          Container(
            height: 130,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
                bottom: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 12,
              itemBuilder: (context, index) {
                return Container(
                  width: 80,
                  margin: const EdgeInsets.only(right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 68,
                        height: 68,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color.fromARGB(255, 217, 88, 193),
                            width: 3,
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            // Handle avatar tap
                            debugPrint('Avatar $index tapped');
                          },
                          customBorder: const CircleBorder(),
                          child: ClipOval(
                            child: Image.asset(
                              'asset/images/avatar.jpg',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.account_circle,
                                color: Colors.blue,
                                size: 60,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'User $index',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const StoriesSection(),
          Expanded(child: NewFeedSection()),
        ],
      ),
      // ...existing code...
      // ...existing code...
    );
  }
}
