import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather_api/models/weather_model.dart';

import '../../../Api/weather_api.dart';

part 'weather_list_event.dart';
part 'weather_list_state.dart';

class WeatherListBloc extends Bloc<WeatherListEvent, WeatherListState> {
  WeatherListApi weatherListApi = WeatherListApi();

  late WeatherModel weatherModel;

  WeatherListBloc() : super(WeatherListInitial()) {
    on<FetchWeatherListEvent>((event, emit) async {
      emit(WeatherListBlocLoading());

      try {
        final weather = await weatherListApi.getweather();

        emit(WeatherListBlocLoaded(weather));
      } catch (e) {
        print("ERROR: $e");

        emit(WeatherListBlocError());
      }
    });
    on<SearchWeatherEvent>((event, emit) async {
      emit(WeatherListBlocLoading());
      try {
        final weather = await weatherListApi.getWeatherByCity(event.city);
        emit(WeatherListBlocLoaded(weather));
      } catch (e ) {
        print("SEARCH ERROR: $e");
      }
    }
    
    );
  }
}
