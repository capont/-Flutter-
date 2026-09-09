import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../viewmodels/calendar_viewmodel.dart';
import '../widgets/calendar_cell.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with AutomaticKeepAliveClientMixin {
  final CalendarViewModel _viewModel = CalendarViewModel();
  final RefreshController _refreshController = RefreshController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onChanged);
    _viewModel.fetchCalendar();
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
      appBar: AppBar(title: const Text('财经日历')),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: () => _viewModel.fetchCalendar(),
        child: _viewModel.events.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _viewModel.events.length,
                itemBuilder: (context, index) => CalendarCell(event: _viewModel.events[index]),
              ),
      ),
    );
  }
}
