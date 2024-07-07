import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:wheather_app/const.dart';
import 'package:wheather_app/prefclass.dart';

class Search_Screen extends StatefulWidget {
  final Function(Weather, String) updateWeather;

  const Search_Screen({Key? key, required this.updateWeather}) : super(key: key);

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  final WeatherFactory wf = WeatherFactory(OPEN_WEATHER_API_KEY);
  Weather? weather;
  String? cityName;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) {
                      cityName = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Search City...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (cityName != null && cityName!.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        weather = await wf.currentWeatherByCityName(cityName!);
                        await PreferencesClass.saveLastSearchedCity(cityName!);
                        widget.updateWeather(weather!, cityName!);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Error while fetching weather data: $e"),
                        ));
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter a city name")),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
                SizedBox(height: 20),
                isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
