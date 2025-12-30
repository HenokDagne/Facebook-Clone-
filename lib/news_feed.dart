// news_feed.dart
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class NewsFeed {
  final String title;
  final String content;
  final String author;
  final String profileImageUrl;
  final String username;
  final String category;
  final String imageUrl;
  final String publishDate;

  NewsFeed({
    required this.title,
    required this.content,
    required this.author,
    required this.profileImageUrl,
    required this.username,
    required this.category,
    required this.imageUrl,
    required this.publishDate,
  });

  factory NewsFeed.fromJson(Map<String, dynamic> json) {
    final user = json['user'] as Map<String, dynamic>?;

    return NewsFeed(
      title: json['title']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      author: json['author']?.toString() ?? user?['name']?.toString() ?? '',
      profileImageUrl: user?['avatar_url']?.toString() ?? '',
      username: user?['username']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      publishDate: json['publish_date']?.toString() ?? '',
    );
  }

  static Future<List<NewsFeed>> loadNewsFeed() async {
    try {
      final String response = await rootBundle.loadString('asset/news.json');
      final decoded = json.decode(response);

      // Expecting: { "news": [ ... ] }
      if (decoded is! Map<String, dynamic>) {
        debugPrint('news.json root is not a Map');
        return [];
      }

      final list = decoded['news'];
      if (list is! List) {
        debugPrint('news.json["news"] is not a List');
        return [];
      }

      return list
          .where((e) => e is Map<String, dynamic>)
          .map((e) => NewsFeed.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error reading news feed: $e');
      return [];
    }
  }
}
