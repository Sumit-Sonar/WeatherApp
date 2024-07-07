# WeatherApp
 an weather app

A simple Flutter app to display weather information using the OpenWeatherMap API.

## Features

- Display current weather conditions (temperature, description, humidity, wind speed).
- Refresh weather data for a selected city.
- Responsive design for both mobile and tablet devices.

## Getting Started

To run this project locally, follow these steps:

### Prerequisites

- Flutter SDK installed (version X.X.X)
- Either Android Studio with the Flutter plugin or Visual Studio Code with the Flutter extension installed.

### Installing

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/your_username/your_repository.git
Navigate into the project directory:

bash
Copy code
cd your_repository
Fetch dependencies:

bash
Copy code
flutter pub get
Running the App
Ensure you have a connected device (emulator, simulator, or physical device).

Run the app with the following command:

bash
Copy code
flutter run
Usage
On the main screen, enter a city name in the search bar and tap "Search" to fetch weather information for that city.
After the weather data loads, you can see the temperature, weather description, humidity, and wind speed.
Tap the refresh button (located at the bottom right) to update the weather data for the last searched city.

Notes
This app uses the OpenWeatherMap API for fetching weather data. Make sure you have an API key from OpenWeatherMap and replace OPEN_WEATHER_API_KEY in lib/const.dart with your API key.
The app supports both portrait and landscape orientations on mobile devices.
For tablet devices, the layout adjusts to utilize the larger screen space effectively.

Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to create an issue or submit a pull request.
