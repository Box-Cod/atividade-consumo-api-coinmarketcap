class Coin {
  final int? id;
  final String name;
  final String symbol;
  final String dateAdded;
  final double priceUSD;
  final double priceBRL;

  const Coin({
    this.id,
    required this.name,
    required this.symbol,
    required this.dateAdded,
    required this.priceUSD,
    required this.priceBRL,
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    final priceUSD = json['quote']['USD']['price']?.toDouble() ?? 0.0;
    final priceBRL = (priceUSD * 5.59)?.toDouble() ?? 0.0;

    return Coin(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      dateAdded: json['date_added'],
      priceUSD: priceUSD,
      priceBRL: priceBRL,
    );
  }
}
