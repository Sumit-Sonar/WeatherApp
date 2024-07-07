import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:wheather_app/const.dart';

class Weather_info extends StatefulWidget {
  final Weather? weather;
  final String? city;

  const Weather_info({Key? key, this.weather, this.city}) : super(key: key);

  @override
  State<Weather_info> createState() => _Weather_infoState();
}

class _Weather_infoState extends State<Weather_info> {
  WeatherFactory wf = WeatherFactory(OPEN_WEATHER_API_KEY);
  Weather? currentWeather;
  DateTime? now;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    currentWeather = widget.weather;
    now = widget.weather?.date;
  }

  Future<void> refreshWeather() async {
    if (widget.city != null && widget.city!.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      WeatherFactory wf = WeatherFactory(OPEN_WEATHER_API_KEY);
      try {
        Weather refreshedWeather =
            await wf.currentWeatherByCityName(widget.city!);
        setState(() {
          currentWeather = refreshedWeather;
          now = refreshedWeather.date;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error while refreshing weather data: $e")),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String buildWeatherIconUrl() {
    if (currentWeather != null && currentWeather!.weatherIcon != null) {
      return 'https://openweathermap.org/img/wn/${currentWeather!.weatherIcon}@4x.png';
    }
    return '';
  }

  Widget buildWeatherInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (currentWeather != null && widget.city != null) ...[
            SizedBox(height: 20),
            Text(
              widget.city!.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Temperature: ${currentWeather!.temperature?.celsius?.toStringAsFixed(1)}°C",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            Image.network(
              buildWeatherIconUrl(),
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              "Weather: ${currentWeather!.weatherDescription}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    "Humidity: ${currentWeather!.humidity}%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Wind Speed: ${currentWeather!.windSpeed?.toStringAsFixed(1)} m/s",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E1E1E),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildWeatherInfo(),
                ],
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            ),
          Padding(
            padding: const EdgeInsets.only(top: 550, left: 280),
            child: Positioned(
              bottom: 20,
              right: 20,
              child: ElevatedButton(
                onPressed: refreshWeather,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  backgroundColor: Colors.grey,
                  padding: EdgeInsets.all(16),
                ),
                child: Icon(Icons.refresh, size: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
