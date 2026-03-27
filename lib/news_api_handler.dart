import 'dart:convert';
import 'package:http/http.dart' as http;
import 'news_feed.dart';

class NewsApiHandler {
  static const String _apiUrl =
      'https://newsapi.org/v2/everything?q=tesla&from=2026-02-27&sortBy=publishedAt&apiKey=8576a3c9b8d44a85b75a65ffbb64105a';

  static Future<List<NewsFeed>> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final articles = decoded['articles'];
        if (articles is List) {
          return articles
              .where((e) => e is Map<String, dynamic>)
              .map((e) => NewsFeed.fromNewsApiJson(e as Map<String, dynamic>))
              .toList();
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching news from API: $e');
    }
    return [];
  }
}
