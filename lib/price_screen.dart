import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/coin_price_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> currencies = [];

    for (String currency in currenciesList) {
      currencies.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: currencies,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
        getData();
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> currencies = [];

    for (String currency in currenciesList) {
      currencies.add(
        Text(currency),
      );
    }

    return CupertinoPicker(
      backgroundColor: Colors.cyan,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        selectedCurrency = currenciesList[selectedIndex];
        getData();
      },
      children: currencies,
    );
  }

  String bitcoinValue = '?';
  String etheriumValue = '?';
  String ltcValue = '?';

  void getData() async {
    try {
      double btcData =
          await CoinData().getCoinData(selectedCurrency, cryptoList[0]);
      double ethData =
          await CoinData().getCoinData(selectedCurrency, cryptoList[1]);
      double ltcData =
          await CoinData().getCoinData(selectedCurrency, cryptoList[2]);

      setState(() {
        bitcoinValue = btcData.toStringAsFixed(0);
        etheriumValue = ethData.toStringAsFixed(0);
        ltcValue = ltcData.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Coin Ticker',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CoinPriceCard(
                coin: cryptoList[0],
                bitcoinValue: bitcoinValue,
                selectedCurrency: selectedCurrency,
              ),
              CoinPriceCard(
                coin: cryptoList[1],
                bitcoinValue: etheriumValue,
                selectedCurrency: selectedCurrency,
              ),
              CoinPriceCard(
                coin: cryptoList[2],
                bitcoinValue: ltcValue,
                selectedCurrency: selectedCurrency,
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.cyan,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}
