import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../viewmodels/quote_viewmodel.dart';
import '../widgets/quote_card.dart';

class QuoteOverviewPage extends StatefulWidget {
  const QuoteOverviewPage({super.key});

  @override
  State<QuoteOverviewPage> createState() => _QuoteOverviewPageState();
}

class _QuoteOverviewPageState extends State<QuoteOverviewPage>
    with AutomaticKeepAliveClientMixin {
  final QuoteViewModel _viewModel = QuoteViewModel();
  final RefreshController _refreshController = RefreshController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onViewModelChanged);
    _viewModel.startPolling();
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    setState(() {});
    if (_refreshController.isRefresh) {
      _refreshController.refreshCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('行情总览')),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () => _viewModel.fetchQuotes(),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: _viewModel.quotes.length,
          itemBuilder: (context, index) => QuoteCard(quote: _viewModel.quotes[index]),
        ),
      ),
    );
  }
}
