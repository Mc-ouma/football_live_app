import 'package:football_live_app/domain/entities/news_article.dart';
import 'package:football_live_app/domain/repositories/news_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class GetLatestNews implements UseCase<List<NewsArticle>, NewsParams> {
  final NewsRepository repository;

  GetLatestNews(this.repository);

  @override
  Future<List<NewsArticle>> call(NewsParams params) {
    return repository.getLatestNews(
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

class GetNewsByCategory
    implements UseCase<List<NewsArticle>, CategoryNewsParams> {
  final NewsRepository repository;

  GetNewsByCategory(this.repository);

  @override
  Future<List<NewsArticle>> call(CategoryNewsParams params) {
    return repository.getNewsByCategory(
      params.category,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

class GetNewsArticleById implements UseCase<NewsArticle?, NewsArticleParams> {
  final NewsRepository repository;

  GetNewsArticleById(this.repository);

  @override
  Future<NewsArticle?> call(NewsArticleParams params) {
    return repository.getNewsArticleById(params.id);
  }
}

class SearchNews implements UseCase<List<NewsArticle>, SearchNewsParams> {
  final NewsRepository repository;

  SearchNews(this.repository);

  @override
  Future<List<NewsArticle>> call(SearchNewsParams params) {
    return repository.searchNews(
      params.query,
      page: params.page,
      pageSize: params.pageSize,
    );
  }
}

class NewsParams {
  final int page;
  final int pageSize;

  NewsParams({this.page = 1, this.pageSize = 10});
}

class CategoryNewsParams {
  final String category;
  final int page;
  final int pageSize;

  CategoryNewsParams({
    required this.category,
    this.page = 1,
    this.pageSize = 10,
  });
}

class NewsArticleParams {
  final int id;

  NewsArticleParams({required this.id});
}

class SearchNewsParams {
  final String query;
  final int page;
  final int pageSize;

  SearchNewsParams({
    required this.query,
    this.page = 1,
    this.pageSize = 10,
  });
}
