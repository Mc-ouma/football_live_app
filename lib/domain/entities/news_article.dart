import 'package:equatable/equatable.dart';

class NewsArticle extends Equatable {
  final int id;
  final String title;
  final String summary;
  final String content;
  final String? imageUrl;
  final DateTime publishedDate;
  final String source;
  final String category;
  final List<String> tags;
  final bool isPremium;
  final NewsAuthor? author;
  final List<NewsComment> comments;
  final int viewCount;
  final int likeCount;
  final List<RelatedNewsArticle> relatedArticles;

  const NewsArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.content,
    this.imageUrl,
    required this.publishedDate,
    required this.source,
    required this.category,
    this.tags = const [],
    this.isPremium = false,
    this.author,
    this.comments = const [],
    this.viewCount = 0,
    this.likeCount = 0,
    this.relatedArticles = const [],
  });

  String get formattedDate {
    final now = DateTime.now();
    final difference = now.difference(publishedDate);

    if (difference.inDays > 7) {
      return '${publishedDate.day}/${publishedDate.month}/${publishedDate.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  List<Object?> get props => [
        id,
        title,
        summary,
        content,
        imageUrl,
        publishedDate,
        source,
        category,
        tags,
        isPremium,
        author,
        comments,
        viewCount,
        likeCount,
        relatedArticles,
      ];
}

class NewsAuthor extends Equatable {
  final int id;
  final String name;
  final String? avatarUrl;
  final String? role;
  final String? bio;

  const NewsAuthor({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.role,
    this.bio,
  });

  @override
  List<Object?> get props => [id, name, avatarUrl, role, bio];
}

class NewsComment extends Equatable {
  final int id;
  final String content;
  final String authorName;
  final String? authorAvatar;
  final DateTime timestamp;
  final int likeCount;
  final List<NewsComment> replies;

  const NewsComment({
    required this.id,
    required this.content,
    required this.authorName,
    this.authorAvatar,
    required this.timestamp,
    this.likeCount = 0,
    this.replies = const [],
  });

  @override
  List<Object?> get props => [
        id,
        content,
        authorName,
        authorAvatar,
        timestamp,
        likeCount,
        replies,
      ];
}

class RelatedNewsArticle extends Equatable {
  final int id;
  final String title;
  final String? imageUrl;
  final DateTime publishedDate;
  final String category;

  const RelatedNewsArticle({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.publishedDate,
    required this.category,
  });

  @override
  List<Object?> get props => [id, title, imageUrl, publishedDate, category];
}
