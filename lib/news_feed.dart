// news_feed.dart
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'news_api_handler.dart';

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

  // Factory for NewsAPI.org response
  factory NewsFeed.fromNewsApiJson(Map<String, dynamic> json) {
    return NewsFeed(
      title: json['title']?.toString() ?? '',
      content: json['description']?.toString() ?? '',
      author: json['author']?.toString() ?? '',
      profileImageUrl: json['urlToImage']?.toString() ?? '',
      username: json['source']?['name']?.toString() ?? '',
      category: '',
      imageUrl: json['urlToImage']?.toString() ?? '',
      publishDate: json['publishedAt']?.toString() ?? '',
    );
  }

  static Future<List<NewsFeed>> loadNewsFeed() async {
    // Fetch from NewsApiHandler (remote API)
    try {
      // ignore: import_of_legacy_library_into_null_safe
      // ignore: unused_import
      
      // ignore: undefined_function
      return await NewsApiHandler.fetchNews();
    } catch (e) {
      debugPrint('Error fetching news feed from API: $e');
      return [];
    }
  }
}
