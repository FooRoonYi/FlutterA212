import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cryptocurrency_exchange/crypto.dart';

class ExchangeCrypto extends StatelessWidget {
  const ExchangeCrypto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
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

  TextEditingController cryptoEditingController = TextEditingController();
  String desc = "No record";
  var name = "", unit = "", value = 0.0, type = "", result = 0.0;
  Crypto curcrypto = Crypto("null", 0.0, "null", "null", 0.0);

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
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Column(
              children: [
                Image.asset('assets/images/crypto2.jpg', scale: 5),
                const SizedBox(height: 10.0),
                const Text("Cryptocurrency Exchange",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
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
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 10.0),
                      hintText:
                          "How many Bitcoin valuesdo you want to exchange?",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: _cryptoButton,
                  child: const Text("Exchange it!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(0xFF, 0xFF, 0xEE, 0x38),
                      )),
                  style: ElevatedButton.styleFrom(primary: Colors.black87),
                ),
                const SizedBox(height: 8.0),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: Cryptogrid(
                    curcrypto: curcrypto,
                  ),
                ),
              ],
            ),
          )
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
      double crypto = double.parse(cryptoEditingController.text);
      setState(() {
        result = crypto * value;
        desc = "$type =  current $name is $unit $value.";
      });
    } else {
      setState(() {
        desc = "No record";
      });
    }
    curcrypto = Crypto(name, value, unit, type, result);
  }
}

class Cryptogrid extends StatefulWidget {
  final Crypto curcrypto;
  const Cryptogrid({Key? key, required this.curcrypto}) : super(key: key);

  @override
  State<Cryptogrid> createState() => _CryptogridState();
}

class _CryptogridState extends State<Cryptogrid> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        GestureDetector(
          //onTap: _cryptoButton,
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.monetization_on_rounded,
                    size: 42,
                  ),
                  const Text("Type",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(widget.curcrypto.type,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal))
                ],
              ),
              color: const Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.turned_in_rounded,
                size: 42,
              ),
              const Text("Name",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.curcrypto.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal))
            ],
          ),
          color: const Color.fromARGB(0xFF, 0xE0, 0xE0, 0xE0),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.credit_card_rounded,
                size: 42,
              ),
              const Text("Value",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.curcrypto.result.toString(),
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal))
            ],
          ),
          color: const Color.fromARGB(0xFF, 0xD6, 0xD6, 0xD6),
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Icon(
                Icons.money_rounded,
                size: 42,
              ),
              const Text("Unit",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.curcrypto.unit,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal))
            ],
          ),
          color: const Color.fromARGB(0xFF, 0xBD, 0xBD, 0xBD),
        ),
      ],
      scrollDirection: Axis.vertical,
    );
  }
}
