part of 'weather_list_bloc.dart';

@immutable
sealed class WeatherListEvent {}
class FetchWeatherListEvent extends WeatherListEvent {}
