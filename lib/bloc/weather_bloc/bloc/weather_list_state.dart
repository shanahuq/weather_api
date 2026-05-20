part of 'weather_list_bloc.dart';

@immutable
sealed class WeatherListState {}

final class WeatherListInitial extends WeatherListState {}
class WeatherListBlocLoading extends WeatherListState {}
class WeatherListBlocLoaded extends WeatherListState {
    final WeatherModel weatherModel;

  WeatherListBlocLoaded(this.weatherModel);
}
class WeatherListBlocError extends WeatherListState {
  
}
