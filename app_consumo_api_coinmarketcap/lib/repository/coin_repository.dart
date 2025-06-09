import 'package:app_consumo_api_coinmarketcap/repository/model/coin.dart';
import 'package:app_consumo_api_coinmarketcap/service/coin_service.dart';

class CoinRepository {
  final CoinService service;

  CoinRepository(this.service);

  Future<List<Coin>> fetchCoins(String symbols) async {
    return await service.fetchCoins(symbols);
  }
}
