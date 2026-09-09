import 'package:flutter/material.dart';
import '../models/calendar_event.dart';

class CalendarCell extends StatelessWidget {
  final CalendarEvent event;

  const CalendarCell({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            const SizedBox(height: 4),
            Text('${event.date} ${event.time}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              children: [
                if (event.actual != null) _buildTag('实际', event.actual!),
                if (event.forecast != null) _buildTag('预测', event.forecast!),
                if (event.previous != null) _buildTag('前值', event.previous!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text('$label: $value', style: const TextStyle(fontSize: 12)),
    );
  }
}
