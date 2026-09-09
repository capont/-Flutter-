import 'package:flutter/material.dart';
import 'views/quote_overview_page.dart';
import 'views/calendar_page.dart';
import 'views/news_page.dart';

void main() {
  runApp(const MarketQuoteApp());
}

class MarketQuoteApp extends StatelessWidget {
  const MarketQuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '行情监控台',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      darkTheme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const MainTabPage(),
    );
  }
}

class MainTabPage extends StatefulWidget {
  const MainTabPage({super.key});

  @override
  State<MainTabPage> createState() => _MainTabPageState();
}

class _MainTabPageState extends State<MainTabPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    QuoteOverviewPage(),
    CalendarPage(),
    NewsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: '行情'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: '财经日历'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: '要闻'),
        ],
      ),
    );
  }
}
