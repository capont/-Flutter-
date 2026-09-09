import 'package:flutter/material.dart';
import '../models/quote_model.dart';

class QuoteCard extends StatelessWidget {
  final QuoteModel quote;

  const QuoteCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    final color = quote.isUp ? Colors.red : Colors.green;
    final sign = quote.isUp ? '+' : '';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(quote.displayName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(quote.price.toStringAsFixed(2),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
                const Spacer(),
                Text('$sign${quote.changeVal.toStringAsFixed(2)} (${quote.changePct.toStringAsFixed(2)}%)',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: color)),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '今开 ${quote.open.toStringAsFixed(2)}  最高 ${quote.high.toStringAsFixed(2)}\n'
              '最低 ${quote.low.toStringAsFixed(2)}  昨收 ${quote.prevClose.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
