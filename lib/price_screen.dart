import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, double> prices;

  @override
  void initState() {
    super.initState();
    updateUI(selectedCurrency);
  }

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> items = [];

    for (String currency in currenciesList) {
      items.add(DropdownMenuItem(
        child: Text(currency),
        value: currency,
      ));
    }
    return items;
  }

  List<Widget> getCupertinoDropdownItems() {
    List<Widget> items = [];

    for (String currency in currenciesList) {
      items.add(Text(currency));
    }
    return items;
  }

  updateUI(String currency) async {
    CoinData coinData = CoinData(currency: currency);
    prices = await coinData.getCoinData();
    setState(() {
      prices = prices;
      selectedCurrency = currency;
    });
  }

  getPlatformSpecificItems() {
    if (Platform.isAndroid) {
      return DropdownButton<String>(
        value: selectedCurrency,
        items: getDropdownItems(),
        onChanged: (value) {
          updateUI(value);
        },
      );
    } else {
      return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32,
        onSelectedItemChanged: (value) {
          updateUI(currenciesList[value]);
        },
        children: getCupertinoDropdownItems(),
      );
    }
  }

  renderCryptoCards() {
    List<Widget> cards = [];
    for (String crypto in cryptoList) {
      cards.add(
        Padding(
          padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
          child: Card(
            color: Colors.lightBlueAccent,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
              child: Text(
                '1 $crypto = ${prices == null ? '?' : prices[crypto]} $selectedCurrency',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: renderCryptoCards(),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPlatformSpecificItems()),
        ],
      ),
    );
  }
}
