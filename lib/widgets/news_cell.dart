import 'package:flutter/material.dart';
import '../models/news_item.dart';

class NewsCell extends StatelessWidget {
  final NewsItem news;
  final VoidCallback? onTap;

  const NewsCell({super.key, required this.news, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        title: Text(news.title, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            '${news.source} · ${news.tag ?? ''} · ${news.publishTime ?? ''}',
            style: const TextStyle(fontSize: 12),
          ),
        ),
        trailing: news.link != null ? const Icon(Icons.open_in_new, size: 16) : null,
        onTap: onTap,
      ),
    );
  }
}
