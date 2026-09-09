import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import '../viewmodels/news_viewmodel.dart';
import '../widgets/news_cell.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with AutomaticKeepAliveClientMixin {
  final NewsViewModel _viewModel = NewsViewModel();
  final RefreshController _refreshController = RefreshController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onChanged);
    _viewModel.fetchNews();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onChanged);
    _refreshController.dispose();
    super.dispose();
  }

  void _onChanged() {
    setState(() {});
    if (_refreshController.isRefresh) _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('要闻')),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () => _viewModel.fetchNews(),
        child: _viewModel.newsItems.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _viewModel.newsItems.length,
                itemBuilder: (context, index) => NewsCell(
                  news: _viewModel.newsItems[index],
                  onTap: () {
                    final link = _viewModel.newsItems[index].link;
                    if (link != null) launchUrl(Uri.parse(link));
                  },
                ),
              ),
      ),
    );
  }
}
