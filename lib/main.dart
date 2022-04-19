import 'package:bitcoin_ticker/constants.dart';
import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: kScafoldBackground,
        // accentColor: Colors.cyan,
        cardColor: Colors.cyan,
        scaffoldBackgroundColor: kScafoldBackground,
      ),
      home: PriceScreen(),
    );
  }
}
