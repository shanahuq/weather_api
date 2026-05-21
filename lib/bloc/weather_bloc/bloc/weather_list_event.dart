part of 'weather_list_bloc.dart';

@immutable
sealed class WeatherListEvent {}
class FetchWeatherListEvent extends WeatherListEvent {}
final class SearchWeatherEvent extends WeatherListEvent {
  final String city;
  SearchWeatherEvent(this.city);
}