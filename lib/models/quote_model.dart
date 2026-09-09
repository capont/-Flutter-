class QuoteModel {
  final String symbol;
  final String displayName;
  final double price;
  final double open;
  final double high;
  final double low;
  final double prevClose;

  QuoteModel({
    required this.symbol,
    required this.displayName,
    required this.price,
    required this.open,
    required this.high,
    required this.low,
    required this.prevClose,
  });

  factory QuoteModel.fromJson(Map<String, dynamic> json, String symbol, String displayName) {
    return QuoteModel(
      symbol: symbol,
      displayName: displayName,
      price: (json['price'] ?? 0).toDouble(),
      open: (json['open'] ?? 0).toDouble(),
      high: (json['high'] ?? 0).toDouble(),
      low: (json['low'] ?? 0).toDouble(),
      prevClose: (json['prevClose'] ?? 0).toDouble(),
    );
  }

  double get changeVal => price - prevClose;
  double get changePct => prevClose > 0 ? (changeVal / prevClose) * 100.0 : 0;
  bool get isUp => changeVal >= 0;
}
