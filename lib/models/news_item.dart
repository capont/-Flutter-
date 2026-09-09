class NewsItem {
  final String title;
  final String source;
  final String? tag;
  final String? link;
  final String? publishTime;

  NewsItem({
    required this.title,
    required this.source,
    this.tag,
    this.link,
    this.publishTime,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      title: json['title'] ?? '',
      source: json['source'] ?? '',
      tag: json['category'] ?? json['tag'],
      link: json['link'],
      publishTime: json['pubDate'] ?? json['time'],
    );
  }
}
