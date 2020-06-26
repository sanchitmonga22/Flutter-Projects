import 'package:bitcoin_ticker/CryptoData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' as Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String getvalue1 = '0';
  String getvalue2 = '0';
  String getvalue3 = '0';

  List<DropdownMenuItem<String>> getDropDownItems() {
    List<DropdownMenuItem<String>> item = [];
    currenciesList.forEach((element) {
      item.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return item;
  }

  @override
  void initState() {
    super.initState();
    getExchangeData();
  }

  List<Widget> getCupertinoItems() {
    List<Widget> items = [];
    currenciesList.forEach((element) {
      items.add(Text(
        element,
        style: TextStyle(color: Colors.white),
      ));
    });
    return items;
  }

  Future<void> getExchangeData() async {
    List<String> data = await Crypto().getExchangedList(selectedCurrency);
    setState(() {
      getvalue1 = data[0];
      getvalue2 = data[1];
      getvalue3 = data[2];
    });
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
          Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Column(
                        children: [
                          Text(
                            '1 ${cryptoList[0]} = $getvalue1 $selectedCurrency',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '1 ${cryptoList[1]} = $getvalue2 $selectedCurrency',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '1 ${cryptoList[2]} = $getvalue3 $selectedCurrency',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          )
                        ],
                      )))),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.Platform.isIOS
                  ? CupertinoPicker(
                      backgroundColor: Colors.lightBlue,
                      itemExtent: 32,
                      onSelectedItemChanged: (selectedIndex) {
                        selectedCurrency = currenciesList[selectedIndex];
                      },
                      children: getCupertinoItems(),
                    )
                  : DropdownButton<String>(
                      value: selectedCurrency,
                      items: getDropDownItems(),
                      onChanged: (value) {
                        setState(() {
                          selectedCurrency = value;
                          getvalue1 = '0';
                          getvalue2 = '0';
                          getvalue3 = '0';
                          getExchangeData();
                        });
                      })),
        ],
      ),
    );
  }
}
