import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: const Text('Hello World'),
          ),
        ),
      ),
    );
  }
}

class MyWeatherPage extends StatefulWidget {
  const MyWeatherPage({ Key? key }) : super(key: key);

  @override
  State<MyWeatherPage> createState() => _MyWeatherPageState();
}

class _MyWeatherPageState extends State<MyWeatherPage> {
  @override
  Widget build(BuildContext context) {
      return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Simple Weather App",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
           DropdownButton(
            itemHeight: 60,
            value: selectLoc,
            onChanged: (newValue) {
              setState(() {
                selectLoc = newValue.toString();
              });
            },
            items: locList.map((selectLoc) {
              return DropdownMenuItem(
                child: Text(
                  selectLoc,
                ),
                value: selectLoc,
              );
            }).toList(),
          ),
          ElevatedButton(
              onPressed: _loadWeather, child: const Text("Load Weather")),
          Expanded(
            child: Weathergrid(
              curweather: curweather,
            ),
          ),
        ],
      ),
    );
  }