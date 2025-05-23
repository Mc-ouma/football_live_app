import 'dart:math';
import 'package:football_live_app/data/models/news_article_model.dart';
import 'package:football_live_app/domain/entities/news_article.dart';
import 'package:football_live_app/domain/repositories/news_repository.dart';

class MockNewsRepository implements NewsRepository {
  final List<NewsArticleModel> _mockNewsArticles = [];

  MockNewsRepository() {
    _generateMockData();
  }

  void _generateMockData() {
    // Create some mock authors
    final authors = [
      NewsAuthorModel(
        id: 1,
        name: 'John Smith',
        avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
        role: 'Senior Football Writer',
        bio:
            'John has been covering football for over 15 years, with expertise in Premier League and European competitions.',
      ),
      NewsAuthorModel(
        id: 2,
        name: 'Emma Johnson',
        avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
        role: 'Football Correspondent',
        bio:
            'Emma specializes in international football and has covered three World Cups.',
      ),
      NewsAuthorModel(
        id: 3,
        name: 'Raj Patel',
        avatarUrl: 'https://randomuser.me/api/portraits/men/67.jpg',
        role: 'Transfer Specialist',
        bio:
            'Raj is known for his insider knowledge of transfers and player contracts across European leagues.',
      ),
    ];

    // Create some mock comments
    final baseComments = [
      NewsCommentModel(
        id: 1,
        content:
            'This is great news for City fans! Four titles in a row is incredible.',
        authorName: 'FootballFan123',
        authorAvatar: 'https://randomuser.me/api/portraits/men/92.jpg',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        likeCount: 24,
        replies: [
          NewsCommentModel(
            id: 11,
            content: 'Completely agree, what a dynasty they\'ve built.',
            authorName: 'CitizenBlue',
            timestamp:
                DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
            likeCount: 8,
          ),
        ],
      ),
      NewsCommentModel(
        id: 2,
        content: 'Can\'t wait for this final, it\'s going to be amazing!',
        authorName: 'MadridFan2000',
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        likeCount: 31,
      ),
      NewsCommentModel(
        id: 3,
        content:
            'Messi back to Barcelona would be incredible, but I\'m not sure it\'s feasible financially.',
        authorName: 'FootballAnalyst',
        authorAvatar: 'https://randomuser.me/api/portraits/women/46.jpg',
        timestamp: DateTime.now().subtract(const Duration(hours: 12)),
        likeCount: 42,
      ),
    ];

    // Generate mock news articles
    _mockNewsArticles.addAll([
      NewsArticleModel(
        id: 1,
        title: 'Premier League: Manchester City wins fourth consecutive title',
        summary:
            'Manchester City has made history by securing their fourth Premier League title in a row after a victory against West Ham United.',
        content: '''
Manchester City has cemented their place in football history by winning their fourth consecutive Premier League title following a 3-1 victory over West Ham United on the final day of the season.

Pep Guardiola's side needed just a point to secure the title ahead of closest challengers Arsenal, but they made no mistake with a dominant performance at the Etihad Stadium. Goals from Kevin De Bruyne, Phil Foden, and Erling Haaland ensured that the title would remain in the blue half of Manchester.

This achievement makes City the first team in English football history to win four top-flight titles in a row, surpassing the record of three consecutive championships previously shared with Manchester United and Liverpool.

"This is an incredible achievement for this group of players and staff," said Guardiola after the match. "To maintain this level of consistency over four seasons in the toughest league in the world shows the character and quality we have in this team."

Captain İlkay Gündoğan lifted the trophy in front of jubilant home fans as celebrations began in earnest. The triumph adds another chapter to City's dominant era under Guardiola, who has now won six Premier League titles since arriving in Manchester in 2016.

The victory also keeps alive City's hopes of repeating last season's treble, with the FA Cup final against Manchester United still to come next weekend.
        ''',
        imageUrl:
            'https://media.gettyimages.com/id/1656491939/photo/manchester-city-v-fc-barcelona-champions-league-group-a.jpg?s=2048x2048&w=gi&k=20&c=nPNUxDKCgxhkMPpfeiT1VR3fNlX0Kx63-bHK6dWIYoE=',
        publishedDate: DateTime.now().subtract(const Duration(hours: 5)),
        source: 'Football News Network',
        category: 'Premier League',
        tags: [
          'Manchester City',
          'Premier League',
          'Champions',
          'Pep Guardiola'
        ],
        author: authors[0],
        comments: baseComments.sublist(0, 1),
        viewCount: 12453,
        likeCount: 876,
        relatedArticles: [
          RelatedNewsArticleModel(
            id: 6,
            title: 'Arsenal finish second despite record points haul',
            imageUrl:
                'https://media.gettyimages.com/id/2048841517/photo/arsenal-fc-v-everton-fc-premier-league.jpg?s=2048x2048&w=gi&k=20&c=pIpFPvIcdJVLc-1AziyfjS_tMCxBs99A_9EhE7W2yCo=',
            publishedDate: DateTime.now().subtract(const Duration(hours: 6)),
            category: 'Premier League',
          ),
          RelatedNewsArticleModel(
            id: 7,
            title: 'Guardiola extends Manchester City contract until 2026',
            imageUrl:
                'https://media.gettyimages.com/id/2159342482/photo/manchester-city-v-arsenal-fc-premier-league.jpg?s=2048x2048&w=gi&k=20&c=oG3RRnXRPXFcBBejNcQxMYFQgJ9_SVLHQC7Eo817vn0=',
            publishedDate: DateTime.now().subtract(const Duration(days: 2)),
            category: 'Premier League',
          ),
        ],
      ),
      NewsArticleModel(
        id: 2,
        title: 'Champions League final set for next weekend',
        summary:
            'Real Madrid and Borussia Dortmund will face off in the Champions League final next Saturday at Wembley Stadium.',
        content: '''
The stage is set for a fascinating UEFA Champions League final as Real Madrid and Borussia Dortmund prepare to face off at Wembley Stadium next Saturday.

Real Madrid, seeking their 15th European Cup/Champions League title, reached the final after overcoming Bayern Munich in a thrilling semi-final that went to extra time. Carlo Ancelotti's side continues to show their remarkable resilience in the competition, with Vinicius Junior and Jude Bellingham proving crucial in their journey to London.

Dortmund, meanwhile, have been the surprise package of this season's competition. After finishing top of a difficult group that included Paris Saint-Germain, AC Milan, and Newcastle United, they eliminated PSV Eindhoven, Atletico Madrid, and then stunned Paris Saint-Germain in the semi-finals.

This will be Dortmund's third Champions League final appearance, having won the competition in 1997 and finished as runners-up to Bayern Munich in 2013.

For Real Madrid, victory would extend their record as the most successful club in the competition's history, while Dortmund are looking to cause an upset against the Spanish giants.

"We know we're facing the kings of this competition," said Dortmund coach Edin Terzic. "But we've shown throughout this campaign that we can compete with anyone, and we go to Wembley believing we can win."

The final kicks off at 8:00 PM BST on Saturday and will be broadcast in over 200 countries worldwide.
        ''',
        imageUrl:
            'https://media.gettyimages.com/id/2070133580/photo/uefa-champions-league-logo-ahead-of-the-uefa-champions-league-match-between-juventus-fc-and.jpg?s=2048x2048&w=gi&k=20&c=O9JY75DvdF9CWgQl3UydAwW2JHzQXvyxWGAV1UXRR-c=',
        publishedDate: DateTime.now().subtract(const Duration(hours: 10)),
        source: 'UEFA Official',
        category: 'Champions League',
        tags: [
          'Real Madrid',
          'Borussia Dortmund',
          'Champions League',
          'Final',
          'Wembley'
        ],
        author: authors[1],
        comments: baseComments.sublist(1, 2),
        viewCount: 28974,
        likeCount: 1453,
        isPremium: true,
        relatedArticles: [
          RelatedNewsArticleModel(
            id: 8,
            title:
                'Jude Bellingham: From Birmingham to Madrid\'s Champions League hero',
            imageUrl:
                'https://media.gettyimages.com/id/2150382893/photo/rb-leipzig-v-real-madrid-uefa-champions-league-2023-24.jpg?s=2048x2048&w=gi&k=20&c=_gLc2O7TGHdpavk1XZIuA0TKRQcmTY0Pn-0ZcAI-YSc=',
            publishedDate: DateTime.now().subtract(const Duration(days: 1)),
            category: 'Champions League',
          ),
          RelatedNewsArticleModel(
            id: 9,
            title: 'Champions League set for new format next season',
            imageUrl:
                'https://media.gettyimages.com/id/963813510/photo/champions-league-trophy-in-stadium.jpg?s=2048x2048&w=gi&k=20&c=qfLbN3G_2e4rX7J7_JTZYhTVQvMGbN5FUMStzOhjmyY=',
            publishedDate: DateTime.now().subtract(const Duration(days: 3)),
            category: 'Champions League',
          ),
        ],
      ),
      NewsArticleModel(
        id: 3,
        title: 'Messi considering return to Barcelona',
        summary:
            'Reports suggest that Lionel Messi is in talks for a potential return to FC Barcelona next season after his contract with Inter Miami ends.',
        content: '''
Multiple sources close to Lionel Messi have confirmed that the Argentine superstar is considering a sensational return to Barcelona for one final season before hanging up his boots.

Messi, who left Barcelona for Paris Saint-Germain in 2021 and currently plays for Inter Miami in Major League Soccer, has reportedly been in discussions with Barcelona president Joan Laporta about a potential return to the club where he spent 21 years of his career.

The 36-year-old's contract with Inter Miami includes a break clause that could be activated at the end of the current MLS season, potentially allowing him to make a farewell appearance in Barcelona colors during the 2025-2026 season.

Barcelona's financial situation, which prevented them from re-signing Messi when he left PSG, has improved significantly in the past year. The club has restructured its debt and increased revenue streams, potentially making a short-term deal for Messi viable.

"The door is always open for Leo," said Laporta in a recent interview. "This is his home, and it would be a beautiful story if he could finish his incredible career here."

Messi himself has remained tight-lipped about the speculation, but sources close to the player suggest he is seriously considering the possibility of a Camp Nou farewell.

Any potential return would require approval from La Liga authorities regarding Barcelona's salary cap situation, but there is growing optimism that a solution could be found if all parties wish to proceed.
        ''',
        imageUrl:
            'https://media.gettyimages.com/id/1649651565/photo/inter-miami-cf-v-toronto-fc-mls.jpg?s=2048x2048&w=gi&k=20&c=Tc-yNV-L0LKOxH-U6-KK71BdRQ41kk9XF6zTcmISsXk=',
        publishedDate: DateTime.now().subtract(const Duration(days: 1)),
        source: 'Sports Insider',
        category: 'Transfers',
        tags: ['Messi', 'Barcelona', 'Transfers', 'Inter Miami', 'La Liga'],
        author: authors[2],
        comments: baseComments.sublist(2, 3),
        viewCount: 45672,
        likeCount: 2145,
        relatedArticles: [
          RelatedNewsArticleModel(
            id: 10,
            title:
                'Barcelona\'s financial recovery paves way for big summer signings',
            imageUrl:
                'https://media.gettyimages.com/id/1678048526/photo/fc-barcelona-v-sevilla-fc-laliga-santander.jpg?s=2048x2048&w=gi&k=20&c=FyTFtZmNfh5zq2-Zj3r6Y-qDSyIAaFpOmcH6W7iGXjE=',
            publishedDate: DateTime.now().subtract(const Duration(days: 2)),
            category: 'Transfers',
          ),
          RelatedNewsArticleModel(
            id: 11,
            title:
                'Inter Miami planning to build team around Messi for years to come',
            publishedDate: DateTime.now().subtract(const Duration(days: 5)),
            category: 'MLS',
          ),
        ],
      ),
      NewsArticleModel(
        id: 4,
        title: 'Premier League announces new broadcasting deal',
        summary:
            'The Premier League has announced a record £10 billion broadcasting deal for the next three seasons, marking a significant increase from the previous agreement.',
        content: '''
The Premier League has secured a record-breaking £10 billion (approximately \$12.7 billion) domestic and international broadcasting deal for the three seasons from 2025/26 to 2027/28.

The new agreement represents a 15% increase on the current broadcasting arrangements and reinforces the Premier League's position as the richest football league in the world.

Under the new deal, live UK rights will continue to be shared between Sky Sports, TNT Sports (formerly BT Sport), and Amazon Prime Video, with the BBC retaining highlights rights for its Match of the Day program.

Sky Sports has secured the largest package, with rights to show 215 live matches per season, while TNT Sports will broadcast 52 games and Amazon Prime Video will show 20 matches.

The international rights, which for the first time will be worth more than the domestic deal, have been sold across various regions with significant growth in markets including the United States, the Middle East, and Southeast Asia.

Premier League Chief Executive Richard Masters said: "This outcome is a testament to the appeal of the Premier League and the continuing strength of the football product, with competitive and compelling matches watched by fans around the world."

The increased revenue will benefit all 20 Premier League clubs, with the league's merit-based distribution system ensuring that even the lowest-placed teams will receive substantial income.

However, the gap between the Premier League and other European leagues continues to widen. The new deal means that the Premier League's broadcast revenue will be approximately twice that of its nearest competitor, Spain's La Liga.
        ''',
        imageUrl:
            'https://media.gettyimages.com/id/1243301015/photo/premier-league-branding-is-seen-on-a-digital-board-prior-to-the-premier-league-match-between.jpg?s=2048x2048&w=gi&k=20&c=DPg2C1FcXWbTSlK3E0C3U2Vevf-LDVXc-0i2FVmyxuQ=',
        publishedDate: DateTime.now().subtract(const Duration(days: 2)),
        source: 'Sports Business',
        category: 'Business',
        tags: [
          'Premier League',
          'Broadcasting',
          'Business',
          'Sky Sports',
          'Television'
        ],
        author: authors[0],
        viewCount: 8235,
        likeCount: 421,
        relatedArticles: [
          RelatedNewsArticleModel(
            id: 12,
            title:
                'How the Premier League became a global entertainment powerhouse',
            publishedDate: DateTime.now().subtract(const Duration(days: 4)),
            category: 'Business',
          ),
          RelatedNewsArticleModel(
            id: 13,
            title:
                'Smaller Premier League clubs push for more equitable revenue distribution',
            imageUrl:
                'https://media.gettyimages.com/id/1462540304/photo/premier-league-logo-ahead-of-the-premier-league-match-between-manchester-united-and-tottenham.jpg?s=2048x2048&w=gi&k=20&c=GXkTiGl19H_LqP0nIbJwdm7tFrBFl6_kJbWf4FW67fM=',
            publishedDate: DateTime.now().subtract(const Duration(days: 6)),
            category: 'Business',
          ),
        ],
      ),
      NewsArticleModel(
        id: 5,
        title: 'Injury concerns for England ahead of Euro 2024',
        summary:
            'Several key England players are battling injuries just weeks before the European Championship begins in Germany.',
        content: '''
England manager Gareth Southgate faces a growing injury crisis just weeks before the European Championship begins in Germany, with several key players racing to be fit for the tournament.

Manchester United defender Harry Maguire is the latest concern after suffering a calf injury in United's final Premier League match. The center-back, who has been a cornerstone of England's defense under Southgate, is now doubtful for the tournament that begins on June 14.

Maguire joins a worrying list of injured England players that includes Bukayo Saka and Jack Grealish, who are both nursing hamstring issues, while Luke Shaw hasn't played since February due to a muscle problem.

Most concerning for Southgate is the situation with captain Harry Kane, who was substituted with an ankle problem during Bayern Munich's Champions League semi-final against Real Madrid. Although scans revealed no serious damage, Kane's fitness remains a priority concern.

"We're monitoring all situations closely," said Southgate at a press conference yesterday. "The medical teams from the respective clubs are keeping us updated daily, and we're optimistic that most players will be available for selection."

Southgate must name his provisional squad by May 28, with the final 26-man selection to be submitted to UEFA by June 7, giving injured players limited time to prove their fitness.

England begins its Euro 2024 campaign against Serbia on June 16, before facing Denmark and Slovenia in Group C.

Fitness expert Dr. James Wilson told us: "Tournament preparation is all about peaking at the right time. These players are coming off the back of a long domestic season, and managing their workload will be crucial for England's chances."

England, finalists at the last European Championship in 2021, are among the favorites for the tournament in Germany.
        ''',
        imageUrl:
            'https://media.gettyimages.com/id/1463417379/photo/harry-kane-of-england-celebrates-after-scoring-their-sides-first-goal-during-the-uefa-euro.jpg?s=2048x2048&w=gi&k=20&c=CY07u9PAx7cH15J-qeOm7gH1AcC-2n6xVimr-aMXLY8=',
        publishedDate: DateTime.now().subtract(const Duration(days: 3)),
        source: 'Euro News',
        category: 'International',
        tags: [
          'England',
          'Euro 2024',
          'Injuries',
          'Gareth Southgate',
          'Harry Kane'
        ],
        author: authors[1],
        viewCount: 15324,
        likeCount: 742,
        isPremium: true,
        relatedArticles: [
          RelatedNewsArticleModel(
            id: 14,
            title: 'Euro 2024: Complete tournament schedule and venues',
            imageUrl:
                'https://media.gettyimages.com/id/1426333563/photo/berlin-germany-general-view-inside-the-stadium-prior-to-the-bundesliga-match-between-hertha.jpg?s=2048x2048&w=gi&k=20&c=bZK0gOAYAw27qsWnfZNb0MPiYGsJePQ1CJfS_Ak3Tn4=',
            publishedDate: DateTime.now().subtract(const Duration(days: 5)),
            category: 'International',
          ),
          RelatedNewsArticleModel(
            id: 15,
            title: 'Germany unveils final preparations for hosting Euro 2024',
            publishedDate: DateTime.now().subtract(const Duration(days: 7)),
            category: 'International',
          ),
        ],
      ),
      // Add more news articles as needed
    ]);

    // Add more items with different dates for better testing
    _mockNewsArticles.addAll([
      NewsArticleModel(
        id: 16,
        title: 'Liverpool appoint new manager to succeed Klopp',
        summary:
            'Liverpool FC has announced the appointment of their new head coach who will take over from Jürgen Klopp at the end of the season.',
        content:
            'Liverpool FC has confirmed that Arne Slot will be their new head coach, taking over from Jürgen Klopp who is stepping down after nearly nine years at the club. The 45-year-old Dutch coach joins from Feyenoord, where he won the Eredivisie title last season and the Dutch Cup this year.',
        imageUrl:
            'https://media.gettyimages.com/id/2014873632/photo/feyenoord-v-ajax-dutch-eredivisie.jpg?s=2048x2048&w=gi&k=20&c=dTvdkfYfxWfE8dsfnHy1qJBKn3aGz8nxK8YvcpCOKD0=',
        publishedDate: DateTime.now().subtract(const Duration(days: 10)),
        source: 'Premier League News',
        category: 'Premier League',
        tags: ['Liverpool', 'Arne Slot', 'Jurgen Klopp', 'Manager'],
        author: authors[0],
        viewCount: 33245,
        likeCount: 1876,
      ),
      NewsArticleModel(
        id: 17,
        title: 'World Cup 2026 qualifier groups announced',
        summary:
            'FIFA has announced the qualifying groups for the 2026 World Cup, which will be jointly hosted by the United States, Canada, and Mexico.',
        content:
            'FIFA has announced the qualifying pathways for the expanded 48-team 2026 World Cup, with European teams facing a new league-style qualifying format. The tournament, which will be hosted across the United States, Canada, and Mexico, will feature 16 groups of three teams in the first round.',
        imageUrl:
            'https://media.gettyimages.com/id/1454341553/photo/a-general-view-of-a-qatar-2022-branded-adidas-al-rihla-match-ball-on-the-pitch-prior-to-the.jpg?s=2048x2048&w=gi&k=20&c=97yx2xK_VJdwQz_-z8xQAcwGSv6J3AMsIoG9_OoVl6c=',
        publishedDate: DateTime.now().subtract(const Duration(days: 15)),
        source: 'FIFA Official',
        category: 'International',
        tags: ['World Cup', 'FIFA', 'Qualifiers'],
        author: authors[1],
        viewCount: 20134,
        likeCount: 876,
      ),
      NewsArticleModel(
        id: 18,
        title: 'Bayern Munich secure Bundesliga title on final day',
        summary:
            'Bayern Munich have won their 12th consecutive Bundesliga title after a dramatic final day of the season.',
        content:
            'Bayern Munich secured their 12th consecutive Bundesliga title in dramatic fashion on the final day of the season, edging out Bayer Leverkusen on goal difference after both teams finished on 81 points. It was the closest Bundesliga title race in a decade.',
        imageUrl:
            'https://media.gettyimages.com/id/2055739571/photo/fc-bayern-m%C3%BCnchen-v-fc-augsburg-bundesliga.jpg?s=2048x2048&w=gi&k=20&c=p8YbhyPLAyK16-iQEGlHrlmJSHd63oNLPWv2K9hhdxk=',
        publishedDate: DateTime.now().subtract(const Duration(days: 20)),
        source: 'German Football News',
        category: 'Bundesliga',
        tags: ['Bayern Munich', 'Bundesliga', 'Champions'],
        author: authors[2],
        viewCount: 18567,
        likeCount: 765,
      ),
    ]);
  }

  @override
  Future<List<NewsArticle>> getLatestNews(
      {int page = 1, int pageSize = 10}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Sort news by published date (newest first)
    final sortedNews = List<NewsArticleModel>.from(_mockNewsArticles)
      ..sort((a, b) => b.publishedDate.compareTo(a.publishedDate));

    // Calculate pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = min(startIndex + pageSize, sortedNews.length);

    if (startIndex >= sortedNews.length) {
      return [];
    }

    return sortedNews.sublist(startIndex, endIndex);
  }

  @override
  Future<List<NewsArticle>> getNewsByCategory(String category,
      {int page = 1, int pageSize = 10}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Filter by category and sort by published date
    final filteredNews = _mockNewsArticles
        .where((article) =>
            article.category.toLowerCase() == category.toLowerCase())
        .toList()
      ..sort((a, b) => b.publishedDate.compareTo(a.publishedDate));

    // Calculate pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = min(startIndex + pageSize, filteredNews.length);

    if (startIndex >= filteredNews.length) {
      return [];
    }

    return filteredNews.sublist(startIndex, endIndex);
  }

  @override
  Future<NewsArticle?> getNewsArticleById(int id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      return _mockNewsArticles.firstWhere((article) => article.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<NewsArticle>> searchNews(String query,
      {int page = 1, int pageSize = 10}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    final lowercaseQuery = query.toLowerCase();

    // Search in title, content, and tags
    final searchResults = _mockNewsArticles
        .where((article) =>
            article.title.toLowerCase().contains(lowercaseQuery) ||
            article.content.toLowerCase().contains(lowercaseQuery) ||
            article.tags
                .any((tag) => tag.toLowerCase().contains(lowercaseQuery)))
        .toList()
      ..sort((a, b) => b.publishedDate.compareTo(a.publishedDate));

    // Calculate pagination
    final startIndex = (page - 1) * pageSize;
    final endIndex = min(startIndex + pageSize, searchResults.length);

    if (startIndex >= searchResults.length) {
      return [];
    }

    return searchResults.sublist(startIndex, endIndex);
  }
}
