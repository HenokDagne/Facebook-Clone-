import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, String>> notifications = [
    {
      'avatar': 'asset/images/avatar1.jpg',
      'text': 'Anaya Angel sent you a friend request.',
      'time': '2h',
    },
    {
      'avatar': 'asset/images/avatar2.jpg',
      'text': 'Laurie Lau liked your photo.',
      'time': '3h',
    },
    {
      'avatar': 'asset/images/avatar3.jpg',
      'text': 'Kaleb Negatu commented on your post.',
      'time': '5h',
    },
    {
      'avatar': 'asset/images/avatar4.jpg',
      'text': 'Samson Shiferaw mentioned you in a comment.',
      'time': '1d',
    },
    {
      'avatar': 'asset/images/avatar5.jpg',
      'text': 'Rosa Shatalova accepted your friend request.',
      'time': '2d',
    },
  ];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.blueGrey),
        titleTextStyle: TextStyle(
          color: Color.fromARGB(255, 31, 101, 230),
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (context, index) =>
                  Divider(height: 1, color: Colors.grey.shade200),
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: AssetImage(notification['avatar']!),
                  ),
                  title: Text(
                    notification['text']!,
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    notification['time']!,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  selected: selectedIndex == index,
                  selectedTileColor: Colors.blue.shade50,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          if (selectedIndex != null)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              color: Colors.grey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage(
                          notifications[selectedIndex!]['avatar']!,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          notifications[selectedIndex!]['text']!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Details for this notification would appear here.',
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  SizedBox(height: 8),
                  Text(
                    notifications[selectedIndex!]['time']!,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedIndex = null;
                        });
                      },
                      child: Text('Close'),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
