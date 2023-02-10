import 'package:geolocator/geolocator.dart';
import './networking.dart';

const _openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5/weather';
const _apiKey = '0640c5a69b9a4c9846aa4d66b1000420';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    try {
      NetworkHelper networkHelper = NetworkHelper('$_openWeatherMapUrl?q=$cityName&appid=$_apiKey&units=metric');
      Map weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      return null;
    }
  }

  Future<dynamic> getLocationData() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    var lat = position.latitude;
    var lon = position.longitude;
    NetworkHelper networkHelper = NetworkHelper('$_openWeatherMapUrl?lat=$lat&lon=$lon&appid=$_apiKey&units=metric');
    Map weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }
}
