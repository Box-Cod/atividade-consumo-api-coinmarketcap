import 'package:app_consumo_api_coinmarketcap/repository/coin_repository.dart';
import 'package:app_consumo_api_coinmarketcap/repository/model/coin.dart';
import 'package:app_consumo_api_coinmarketcap/service/coin_service.dart';
import 'package:app_consumo_api_coinmarketcap/ui/home/view_model/store/coin_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CoinStore? _viewModel;
  final TextEditingController _controller = TextEditingController();
  final String deafultCoinsSymbols =
      "BTC,ETH,SOL,BNB,BCH,MKR,AAVE,DOT,SUI,ADA,XRP,TIA,NEO,NEAR,PENDLE,RENDER,LINK,TON,XAI,SEI,IMX,ETHFI,UMA,SUPER,FET,USUAL,GALA,PAAL,AERO";

  @override
  void initState() {
    super.initState();
    final service = CoinService();
    final repository = CoinRepository(service);
    _viewModel = CoinStore(repository);
    _viewModel?.fetchCoins(
      symbols: deafultCoinsSymbols,
    ); // Carrega BTC por padrão
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              _controller.clear();
              _viewModel?.fetchCoins(symbols: deafultCoinsSymbols);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        child: Center(
          child: Card(
            child: ListView(
              padding: const EdgeInsets.all(15),
              children: [
                TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Ex: BTC,ETH,SOL",
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final input = _controller.text.toUpperCase().replaceAll(
                      ' ',
                      '',
                    );
                    if (_controller.text.isNotEmpty) {
                      _viewModel?.fetchCoins(symbols: input);
                    }
                  },
                  child: const Text("Buscar"),
                ),
                const SizedBox(height: 20),
                Observer(
                  builder: (_) {
                    if (_viewModel!.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (_viewModel!.coins.isEmpty) {
                      return const Text("Nenhuma moeda encontrada.");
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _viewModel!.coins.map((Coin coin) {
                        return Card(
                          elevation: 5,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              alignment: Alignment.centerLeft,
                              foregroundColor: Colors.black,
                              backgroundColor: Colors.transparent,
                              side: BorderSide.none,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              textStyle: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Details"),
                                content: Text(
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  " Name: ${coin.name} \n Symbol: ${coin.symbol} \n Date Added: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(coin.dateAdded))} \n Price USD: \$ ${coin.priceUSD.toStringAsFixed(2)} \n Price BRL: R\$ ${coin.priceBRL.toStringAsFixed(2)}",
                                ),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      elevation: 5,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 10,
                                      ),
                                      textStyle: TextStyle(fontSize: 18),
                                    ),
                                    onPressed: () =>
                                        Navigator.pop(context, "OK"),
                                    child: Text("Ok"),
                                  ),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Column(
                                spacing: 5,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Symbol: ${coin.symbol}"),
                                  Text("Name: ${coin.name}"),
                                  Text(
                                    "Price USD: \$ ${coin.priceUSD.toStringAsFixed(2)}",
                                  ),
                                  Text(
                                    "Price BRL: R\$ ${coin.priceBRL.toStringAsFixed(2)}",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        onRefresh: () async {
          _controller.clear();
          _viewModel?.fetchCoins(symbols: deafultCoinsSymbols);
        },
      ),
    );
  }
}
