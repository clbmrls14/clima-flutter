import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';

const String API_KEY = 'your api key here';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {

  Future<dynamic> getWeatherByCity(String cityName) async {
    Uri uri = Uri.parse(
        '$openWeatherMapUrl?q=$cityName&appid=$API_KEY&units=imperial');

    return await _getWeather(uri);
  }

  Future<dynamic> getLocationWeather() async {
    Location location = new Location();
    await location.getCurrentLocation();

    Uri uri = Uri.parse(
        '$openWeatherMapUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$API_KEY&units=imperial');

    return await _getWeather(uri);
  }

  Future<dynamic> _getWeather(Uri uri) async {
    NetworkHelper networkHelper = NetworkHelper(url: uri);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 77) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 68) {
      return 'Time for shorts and ๐';
    } else if (temp < 50) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
