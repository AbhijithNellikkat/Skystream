import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../data/weather_data.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>(fetchWeather);
  }

  FutureOr<void> fetchWeather(
      FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      
      WeatherFactory weatherFactory =
          WeatherFactory(apiKey, language: Language.ENGLISH);

      Weather weather = await weatherFactory.currentWeatherByLocation(
        event.position.latitude,
        event.position.longitude,
      );

      log('$weather');

      emit(WeatherSuccess(weather: weather, position: event.position));
    } catch (e) {
      emit(WeatherFailure());
      log('$e');
    }
  }
}
