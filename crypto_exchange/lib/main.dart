import 'dart:convert';
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptocurrency Exchange App',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Cryptocurrency Exchange App'),
            backgroundColor: Colors.black,
          ),
          body: const CryptoExchangePage()),
    );
  }
}

class CryptoExchangePage extends StatefulWidget {
  const CryptoExchangePage({Key? key}) : super(key: key);

  @override
  State<CryptoExchangePage> createState() => _CryptoExchangePageState();
}

class _CryptoExchangePageState extends State<CryptoExchangePage> {
  String selectCrypto = "btc";
  List<String> cryptoList = [
    "btc",
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "dot",
    "yfi",
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
    "clp",
    "cny",
    "czk",
    "dkk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "inr",
    "jpy",
    "krw",
    "kwd",
    "lkr",
    "mmk",
    "mxn",
    "myr",
    "ngn",
    "nok",
    "nzd",
    "php",
    "pkr",
    "pln",
    "rub",
    "sar",
    "sek",
    "sgd",
    "thb",
    "try",
    "twd",
    "uad",
    "vef",
    "vnd",
    "zar",
    "xdr",
    "xag",
    "xau",
    "bits",
    "sats"
  ];

  String desc = "No record";
  var name = "", unit = "", value = 0.0, type = "", crypto = 0.0, result = 0.0;
  TextEditingController cryptoEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/crypto1.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
            child: Column(
              children: [
                Image.asset('assets/images/crypto2.jpg', scale: 4),
                const Text(
                  "Cryptocurrency Exchange",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                DropdownButton(
                  itemHeight: 60,
                  value: selectCrypto,
                  iconEnabledColor: Colors.black,
                  onChanged: (newValue) {
                    setState(() {
                      selectCrypto = newValue.toString();
                    });
                  },
                  items: cryptoList.map((selectCrypto) {
                    return DropdownMenuItem(
                      child: Text(
                        selectCrypto,
                        style: const TextStyle(color: Colors.black),
                      ),
                      value: selectCrypto,
                    );
                  }).toList(),
                ),
                TextField(
                  controller: cryptoEditingController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      hintText: "How many do you want to exchange?",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _cryptoButton,
                  child: const Text("Exchange it!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(0xFF, 0xFF, 0xEE, 0x38),
                      )),
                  style: ElevatedButton.styleFrom(primary: Colors.black87),
                ),
                const SizedBox(height: 10.0),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "You will get " + result.toStringAsFixed(10),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _cryptoButton() async {
    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      name = parsedJson['rates'][selectCrypto]['name'];
      value = parsedJson['rates'][selectCrypto]['value'];
      unit = parsedJson['rates'][selectCrypto]['unit'];
      type = parsedJson['rates'][selectCrypto]['type'];

      crypto = double.parse(cryptoEditingController.text);
      setState(() {
        desc = "$type =  current $name is $unit $value.";
        result = crypto * value;
      });
    } else {
      setState(() {
        desc = "No record";
      });
    }
  }
}
