import 'package:dartz/dartz.dart';
import 'package:football_live_app/core/errors/failures.dart';
import 'package:football_live_app/domain/entities/news_article.dart';
import 'package:football_live_app/domain/repositories/news_repository.dart';
import 'package:football_live_app/domain/usecases/usecase.dart';

class GetLatestNews implements UseCase<List<NewsArticle>, NewsParams> {
  final NewsRepository repository;

  GetLatestNews(this.repository);

  @override
  Future<Either<Failure, List<NewsArticle>>> call(NewsParams params) async {
    try {
      final result = await repository.getLatestNews(
        page: params.page,
        pageSize: params.pageSize,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

class GetNewsByCategory
    implements UseCase<List<NewsArticle>, CategoryNewsParams> {
  final NewsRepository repository;

  GetNewsByCategory(this.repository);

  @override
  Future<Either<Failure, List<NewsArticle>>> call(
      CategoryNewsParams params) async {
    try {
      final result = await repository.getNewsByCategory(
        params.category,
        page: params.page,
        pageSize: params.pageSize,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

class GetNewsArticleById implements UseCase<NewsArticle?, NewsArticleParams> {
  final NewsRepository repository;

  GetNewsArticleById(this.repository);

  @override
  Future<Either<Failure, NewsArticle?>> call(NewsArticleParams params) async {
    try {
      final result = await repository.getNewsArticleById(params.id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

class SearchNews implements UseCase<List<NewsArticle>, SearchNewsParams> {
  final NewsRepository repository;

  SearchNews(this.repository);

  @override
  Future<Either<Failure, List<NewsArticle>>> call(
      SearchNewsParams params) async {
    try {
      final result = await repository.searchNews(
        params.query,
        page: params.page,
        pageSize: params.pageSize,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
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
