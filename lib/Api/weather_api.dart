import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_api/models/weather_model.dart';

import 'api_client.dart';
import 'api_exception.dart';

class WeatherListApi {
  ApiClient apiClient = ApiClient();

  Future<WeatherModel> getweather() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw ApiException("Location permission denied", 403);
    }
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    final lat = position.latitude;
    final lon = position.longitude;
    String url =
        "https://open-weather13.p.rapidapi.com/city?city=malappuram&lang=EN";

    Response response = await apiClient.invokeAPI(url, "GET", null);

    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);

      return WeatherModel.fromJson(jsonMap);
    } else {
      final errorBody = jsonDecode(response.body);

      throw ApiException(
        'Error : ${errorBody['message'] ?? 'Unknown error'}',
        response.statusCode,
      );
    }
  }



  Future<WeatherModel> getWeatherByCity(String city) async {
    String url =
        "https://open-weather13.p.rapidapi.com/city?city=$city&lang=EN";
    Response response = await apiClient.invokeAPI(url, "GET", null);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      final errorBody = jsonDecode(response.body);
      throw ApiException(
        errorBody['message'] ?? "Unknown error",
        response.statusCode,
      );
    }
  }
}
