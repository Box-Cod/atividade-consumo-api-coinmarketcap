import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:app_consumo_api_coinmarketcap/repository/model/coin.dart';

class CoinService {
  final _apiKey = "cfe26d8b-6840-4968-8115-c8c230bbe7e2";

  Future<List<Coin>> fetchCoins(String symbols) async {
    final response = await http.get(
      Uri.parse(
        "https://pro-api.coinmarketcap.com/v2/cryptocurrency/quotes/latest?symbol=${symbols}",
      ),
      headers: {"Accept": "application/json", "X-CMC_PRO_API_KEY": _apiKey},
    );

    if (response.statusCode == 400) throw HttpException("Erro ao buscar!");

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final data = decoded['data'] as Map<String, dynamic>;
      final coins = <Coin>[];

      for (var entry in data.entries) {
        final coinData = entry.value[0];
        coins.add(Coin.fromJson(coinData));
      }

      return coins;
    }

    throw HttpException("Erro inesperado: ${response.statusCode}");
  }
}
