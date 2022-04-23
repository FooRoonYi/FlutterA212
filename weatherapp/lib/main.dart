import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weatherapp/weather.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Weather App',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Weather App'),
            backgroundColor: Colors.lightBlue,
          ),
          body: const MyWeatherPage()),
    );
  }
}

class MyWeatherPage extends StatefulWidget {
  const MyWeatherPage({Key? key}) : super(key: key);

  @override
  State<MyWeatherPage> createState() => _MyWeatherPageState();
}

class _MyWeatherPageState extends State<MyWeatherPage> {
  String selectLoc = "Kulai";
  List<String> locList = [
    "Kulai",
    "Johor Bahru",
    "Batu Pahat",
    "Mersing",
    "Muar"
  ];
  String desc = "No record";
  var temp = 0.0, hum = 0, weather = "", feelsLike = 0.0;
  Weather curweather = Weather("Not Available", 0.0, 0, "Not Available", 0.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Weather App",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
                onPressed: _loadWeather,
                child: const Text("Load Weather"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                )),
            Expanded(
              child: Weathergrid(
                curweather: curweather,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loadWeather() async {
    var apiid = "778f3c9e51979dc8e61eba128faac300";
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=Kulai&appid=778f3c9e51979dc8e61eba128faac300&units=metric');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      temp = parsedJson['main']['temp'];
      hum = parsedJson['main']['humidity'];
      weather = parsedJson['weather'][0]['main'];
      feelsLike = parsedJson['main']['feels_like'];
      curweather = Weather(selectLoc, temp, hum, weather, feelsLike);
      setState(() {
        desc =
            "The current weather in $selectLoc is $weather. The current temperature is $temp Celcius and hemidity is $hum percent. ";
      });
    } else {
      setState(() {
        desc = "No record";
      });
    }
  }
}

class Weathergrid extends StatefulWidget {
  final Weather curweather;
  const Weathergrid({Key? key, required this.curweather}) : super(key: key);

  @override
  State<Weathergrid> createState() => _WeathergridState();
}

class _WeathergridState extends State<Weathergrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        GestureDetector(
          onTap: _pressme,
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Location"),
                  const Icon(
                    Icons.location_city,
                    size: 64,
                  ),
                  Text(widget.curweather.loc)
                ],
              ),
              color: Colors.blue[100],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Weather"),
              const Icon(
                Icons.cloud,
                size: 64,
              ),
              Text(widget.curweather.weather),
            ],
          ),
          color: Colors.blue[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Temp"),
              const Icon(
                Icons.thermostat,
                size: 64,
              ),
              Text(widget.curweather.temp.toString() + " Celcius")
            ],
          ),
          color: Colors.blue[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Humidity"),
              const Icon(
                Icons.hot_tub,
                size: 64,
              ),
              Text(widget.curweather.hum.toString() + "%")
            ],
          ),
          color: Colors.blue[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Feels like"),
              const Icon(
                Icons.thermostat_auto,
                size: 64,
              ),
              Text(widget.curweather.feelsLike.toString() + "celcius")
            ],
          ),
          color: Colors.blue[100],
        ),
      ],
    );
  }

  void _pressme() {
    print("Hello, this is weather today!");
  }
}
