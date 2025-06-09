// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CoinStore on _CoinStoreBase, Store {
  late final _$coinsAtom = Atom(name: '_CoinStoreBase.coins', context: context);

  @override
  ObservableList<Coin> get coins {
    _$coinsAtom.reportRead();
    return super.coins;
  }

  @override
  set coins(ObservableList<Coin> value) {
    _$coinsAtom.reportWrite(value, super.coins, () {
      super.coins = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_CoinStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$fetchCoinsAsyncAction = AsyncAction(
    '_CoinStoreBase.fetchCoins',
    context: context,
  );

  @override
  Future<void> fetchCoins({required String symbols}) {
    return _$fetchCoinsAsyncAction.run(
      () => super.fetchCoins(symbols: symbols),
    );
  }

  @override
  String toString() {
    return '''
coins: ${coins},
isLoading: ${isLoading}
    ''';
  }
}
