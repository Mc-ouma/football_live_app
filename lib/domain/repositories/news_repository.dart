import 'package:football_live_app/domain/entities/news_article.dart';

abstract class NewsRepository {
  Future<List<NewsArticle>> getLatestNews({int page = 1, int pageSize = 10});
  Future<List<NewsArticle>> getNewsByCategory(String category,
      {int page = 1, int pageSize = 10});
  Future<NewsArticle?> getNewsArticleById(int id);
  Future<List<NewsArticle>> searchNews(String query,
      {int page = 1, int pageSize = 10});
}
