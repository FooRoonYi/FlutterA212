import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override //stateful会比stateless多出这个
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double result = 0.0;
  TextEditingController numaEditingController = TextEditingController();
  TextEditingController numbEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello World",
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Hello World",
              //style: TextStyle(color: Colors.black, fontSize: 24),
            ),
            // backgroundColor: Colors.red,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.white,
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Simple Calculator",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text("Enter First Number"),
                    TextField(
                      controller: numaEditingController,
                      decoration: InputDecoration(
                          hintText: "First Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                      keyboardType: const TextInputType.numberWithOptions(),
                    ),
                    const Text("Enter Second Number"),
                    TextField(
                      controller: numbEditingController,
                      decoration: InputDecoration(
                          hintText: "Second Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
                      keyboardType: const TextInputType.numberWithOptions(),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () => {_pressMe("+")},
                            child: const Text("+"),
                          ),
                          ElevatedButton(
                            onPressed: () => {_pressMe("-")},
                            child: const Text("-"),
                          ),
                          ElevatedButton(
                            onPressed: () => {_pressMe("*")},
                            child: const Text("*"),
                          ),
                          ElevatedButton(
                            onPressed: (() => {_pressMe("/")}),
                            child: const Text("/"),
                          ),
                        ]),
                    const SizedBox(height: 20.0),
                    Text(
                      "Result: " + result.toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void _pressMe(String op) {
    setState(() {
      double numa = double.parse(numaEditingController.text);
      double numb = double.parse(numbEditingController.text);
      switch (op) {
        case "+":
          result = numa + numb;
          break;
        case "-":
          result = numa - numb;
          break;
        case "*":
          result = numa * numb;
          break;
        case "/":
          result = numa / numb;
          break;
      }
    });
  }
}
