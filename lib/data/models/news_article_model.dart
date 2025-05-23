import 'package:football_live_app/domain/entities/news_article.dart';

class NewsArticleModel extends NewsArticle {
  const NewsArticleModel({
    required int id,
    required String title,
    required String summary,
    required String content,
    String? imageUrl,
    required DateTime publishedDate,
    required String source,
    required String category,
    List<String> tags = const [],
    bool isPremium = false,
    NewsAuthorModel? author,
    List<NewsCommentModel> comments = const [],
    int viewCount = 0,
    int likeCount = 0,
    List<RelatedNewsArticleModel> relatedArticles = const [],
  }) : super(
          id: id,
          title: title,
          summary: summary,
          content: content,
          imageUrl: imageUrl,
          publishedDate: publishedDate,
          source: source,
          category: category,
          tags: tags,
          isPremium: isPremium,
          author: author,
          comments: comments,
          viewCount: viewCount,
          likeCount: likeCount,
          relatedArticles: relatedArticles,
        );

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      id: json['id'],
      title: json['title'],
      summary: json['summary'] ?? json['short_content'] ?? '',
      content: json['content'],
      imageUrl: json['image_url'],
      publishedDate: DateTime.parse(json['published_date']),
      source: json['source'],
      category: json['category'],
      tags: List<String>.from(json['tags'] ?? []),
      isPremium: json['is_premium'] ?? false,
      author: json['author'] != null
          ? NewsAuthorModel.fromJson(json['author'])
          : null,
      comments: (json['comments'] as List<dynamic>?)
              ?.map((comment) => NewsCommentModel.fromJson(comment))
              .toList() ??
          [],
      viewCount: json['view_count'] ?? 0,
      likeCount: json['like_count'] ?? 0,
      relatedArticles: (json['related_articles'] as List<dynamic>?)
              ?.map((article) => RelatedNewsArticleModel.fromJson(article))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'content': content,
      'image_url': imageUrl,
      'published_date': publishedDate.toIso8601String(),
      'source': source,
      'category': category,
      'tags': tags,
      'is_premium': isPremium,
      'author': author != null ? (author as NewsAuthorModel).toJson() : null,
      'comments': comments
          .map((comment) => (comment as NewsCommentModel).toJson())
          .toList(),
      'view_count': viewCount,
      'like_count': likeCount,
      'related_articles': relatedArticles
          .map((article) => (article as RelatedNewsArticleModel).toJson())
          .toList(),
    };
  }
}

class NewsAuthorModel extends NewsAuthor {
  const NewsAuthorModel({
    required int id,
    required String name,
    String? avatarUrl,
    String? role,
    String? bio,
  }) : super(
          id: id,
          name: name,
          avatarUrl: avatarUrl,
          role: role,
          bio: bio,
        );

  factory NewsAuthorModel.fromJson(Map<String, dynamic> json) {
    return NewsAuthorModel(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatar_url'],
      role: json['role'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar_url': avatarUrl,
      'role': role,
      'bio': bio,
    };
  }
}

class NewsCommentModel extends NewsComment {
  const NewsCommentModel({
    required int id,
    required String content,
    required String authorName,
    String? authorAvatar,
    required DateTime timestamp,
    int likeCount = 0,
    List<NewsCommentModel> replies = const [],
  }) : super(
          id: id,
          content: content,
          authorName: authorName,
          authorAvatar: authorAvatar,
          timestamp: timestamp,
          likeCount: likeCount,
          replies: replies,
        );

  factory NewsCommentModel.fromJson(Map<String, dynamic> json) {
    return NewsCommentModel(
      id: json['id'],
      content: json['content'],
      authorName: json['author_name'],
      authorAvatar: json['author_avatar'],
      timestamp: DateTime.parse(json['timestamp']),
      likeCount: json['like_count'] ?? 0,
      replies: (json['replies'] as List<dynamic>?)
              ?.map((reply) => NewsCommentModel.fromJson(reply))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'author_name': authorName,
      'author_avatar': authorAvatar,
      'timestamp': timestamp.toIso8601String(),
      'like_count': likeCount,
      'replies': (replies as List<NewsCommentModel>)
          .map((reply) => reply.toJson())
          .toList(),
    };
  }
}

class RelatedNewsArticleModel extends RelatedNewsArticle {
  const RelatedNewsArticleModel({
    required int id,
    required String title,
    String? imageUrl,
    required DateTime publishedDate,
    required String category,
  }) : super(
          id: id,
          title: title,
          imageUrl: imageUrl,
          publishedDate: publishedDate,
          category: category,
        );

  factory RelatedNewsArticleModel.fromJson(Map<String, dynamic> json) {
    return RelatedNewsArticleModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image_url'],
      publishedDate: DateTime.parse(json['published_date']),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image_url': imageUrl,
      'published_date': publishedDate.toIso8601String(),
      'category': category,
    };
  }
}
