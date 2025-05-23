import 'package:flutter/material.dart';
import 'package:football_live_app/core/utils/logger.dart';
import 'package:football_live_app/data/repositories/mock_news_repository.dart';
import 'package:football_live_app/domain/entities/news_article.dart';
import 'package:football_live_app/domain/usecases/news/get_news.dart';
import 'package:football_live_app/presentation/pages/news/news_detail_page.dart';
import 'package:intl/intl.dart';

class NewsFeedTab extends StatefulWidget {
  const NewsFeedTab({super.key});

  @override
  State<NewsFeedTab> createState() => _NewsFeedTabState();
}

class _NewsFeedTabState extends State<NewsFeedTab> {
  final _newsRepository = MockNewsRepository();
  late final GetLatestNews _getLatestNews;

  final List<NewsArticle> _newsItems = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMoreContent = true;
  String? _errorMessage;
  int _currentPage = 1;
  final int _pageSize = 10;

  @override
  void initState() {
    super.initState();
    _getLatestNews = GetLatestNews(_newsRepository);
    _loadNewsItems();
  }

  Future<void> _loadNewsItems() async {
    if (_isLoading || _isLoadingMore) return;

    try {
      setState(() {
        _isLoading = true;
      });

      final params = NewsParams(page: 1, pageSize: _pageSize);
      final newsArticles = await _getLatestNews(params);

      setState(() {
        _newsItems.clear();
        _newsItems.addAll(newsArticles);
        _isLoading = false;
        _currentPage = 1;
        _hasMoreContent = newsArticles.length == _pageSize;
      });
    } catch (e, stackTrace) {
      AppLogger.e('Error loading news items', error: e, stackTrace: stackTrace);
      setState(() {
        _errorMessage = 'Failed to load news feed. Please try again.';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMoreNewsItems() async {
    if (_isLoading || _isLoadingMore || !_hasMoreContent) return;

    try {
      setState(() {
        _isLoadingMore = true;
      });

      final params = NewsParams(page: _currentPage + 1, pageSize: _pageSize);
      final newsArticles = await _getLatestNews(params);

      setState(() {
        _newsItems.addAll(newsArticles);
        _isLoadingMore = false;
        _currentPage++;
        _hasMoreContent = newsArticles.length == _pageSize;
      });
    } catch (e, stackTrace) {
      AppLogger.e('Error loading more news items',
          error: e, stackTrace: stackTrace);
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(_errorMessage!, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _errorMessage = null;
                });
                _loadNewsItems();
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _newsItems.clear();
          _isLoading = true;
        });
        await _loadNewsItems();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _newsItems.length,
        itemBuilder: (context, index) {
          final item = _newsItems[index];
          return NewsCard(newsItem: item);
        },
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsArticle newsItem;

  const NewsCard({super.key, required this.newsItem});

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'premier league':
        return Colors.purple;
      case 'champions league':
        return Colors.blue;
      case 'transfers':
        return Colors.green;
      case 'business':
        return Colors.orange;
      case 'international':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');
    final formattedDate = dateFormat.format(newsItem.publishedDate);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () {
          _showNewsDetails(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category and premium badge
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color:
                          _getCategoryColor(newsItem.category).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      newsItem.category,
                      style: TextStyle(
                        color: _getCategoryColor(newsItem.category),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (newsItem.isPremium)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star,
                              size: 12, color: Colors.amber.shade800),
                          const SizedBox(width: 4),
                          Text(
                            'Premium',
                            style: TextStyle(
                              color: Colors.amber.shade800,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            // News image (placeholder color if image is null)
            Container(
              height: 180,
              width: double.infinity,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              child: newsItem.imageUrl != null
                  ? Image.network(
                      newsItem.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.sports_soccer,
                            size: 48,
                            color: Colors.grey.shade500,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Icon(
                        Icons.sports_soccer,
                        size: 48,
                        color: Colors.grey.shade500,
                      ),
                    ),
            ),

            // News title and content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsItem.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    newsItem.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // News source and date
                  Row(
                    children: [
                      Icon(
                        Icons.source_outlined,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        newsItem.source,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),

                  // Tags
                  if (newsItem.tags.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: newsItem.tags.map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '#$tag',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewsDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailPage(newsItem: newsItem),
      ),
    );
  }
}
