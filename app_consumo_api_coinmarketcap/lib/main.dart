import 'package:app_consumo_api_coinmarketcap/ui/home/page/home_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote Coin Cript',
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'Quote Coin Cript'),
    );
  }
}
