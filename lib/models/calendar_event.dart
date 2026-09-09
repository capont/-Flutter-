class CalendarEvent {
  final String title;
  final String originalTitle;
  final String time;
  final String date;
  final String asset;
  final int importance;
  final String? forecast;
  final String? previous;
  final String? actual;
  final String? link;

  CalendarEvent({
    required this.title,
    required this.originalTitle,
    required this.time,
    required this.date,
    required this.asset,
    required this.importance,
    this.forecast,
    this.previous,
    this.actual,
    this.link,
  });

  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    return CalendarEvent(
      title: json['title'] ?? '',
      originalTitle: json['originalTitle'] ?? '',
      time: json['time'] ?? '',
      date: json['date'] ?? '',
      asset: json['asset'] ?? '',
      importance: json['importance'] ?? 0,
      forecast: json['forecast'],
      previous: json['previous'],
      actual: json['actual'],
      link: json['link'],
    );
  }
}
