import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:wheather_app/prefclass.dart';
import 'package:wheather_app/searchscreen.dart';
import 'package:wheather_app/weatherinfo.dart';
import 'package:wheather_app/const.dart';

class Home_Screen extends StatefulWidget {
  final String city;

  const Home_Screen({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  int selectedIndex = 1;
  Weather? weather;
  late String city;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    city = widget.city;
    fetchWeather(city);
    if (city.isNotEmpty && city != "Your City") {
      fetchWeather(city);
    } else {
      selectedIndex = 0; // If no city, start with the search screen
    isLoading = false;
    }
  }

  void fetchWeather(String city) async {
    WeatherFactory wf = WeatherFactory(OPEN_WEATHER_API_KEY);
    try {
      Weather newWeather = await wf.currentWeatherByCityName(city);
      setState(() {
        weather = newWeather;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching weather: $e");
       setState(() {
        isLoading = false;
      });
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void updateWeather(Weather newWeather, String newCity) {
    setState(() {
      weather = newWeather;
      city = newCity;
      selectedIndex = 1;
      isLoading = false;
    });
    PreferencesClass.saveLastSearchedCity(newCity);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Color(0xDD000000),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    List<Widget> widgetOptions = <Widget>[
      Search_Screen(updateWeather: updateWeather),
      weather != null
          ? Weather_info(weather: weather!, city: city)
          : Center(
              child: Text(
                'No Weather Data',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xDD000000),
        title: Text("Weather App", style: TextStyle(color: Colors.white)),
      ),
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xDD000000),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cloud,
              color: Colors.white,
            ),
            label: 'Weather',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.white,
        onTap: onItemTapped,
      ),
    );
  }
}
