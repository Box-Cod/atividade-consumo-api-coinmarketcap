import 'dart:convert';
import 'dart:io';

import 'package:app_consumo_api_coinmarketcap/repository/coin_repository.dart';
import 'package:app_consumo_api_coinmarketcap/repository/model/coin.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

part 'coin_store.g.dart';

class CoinStore = _CoinStoreBase with _$CoinStore;

abstract class _CoinStoreBase with Store {
  final CoinRepository repository;

  _CoinStoreBase(this.repository);

  @observable
  ObservableList<Coin> coins = ObservableList<Coin>();

  @observable
  bool isLoading = false;

  @action
  Future<void> fetchCoins({required String symbols}) async {
    try {
      isLoading = true;
      final result = await repository.fetchCoins(symbols);
      coins = ObservableList.of(result);
    } catch (e) {
      coins = ObservableList<Coin>();
      rethrow;
    } finally {
      isLoading = false;
    }
  }
}
