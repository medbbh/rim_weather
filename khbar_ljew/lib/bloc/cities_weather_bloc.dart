import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:khbar_ljew/data/my_data.dart';
import 'package:weather/weather.dart';

part 'cities_weather_event.dart';
part 'cities_weather_state.dart';

class CitiesWeatherBloc extends Bloc<CitiesWeatherEvent, CitiesWeatherState> {
  CitiesWeatherBloc() : super(CitiesWeatherInitial()) {
    on<FetchWeatherByCountry>((event, emit) async {
      emit(CitiesWeatherLoading());
      try {
        List<String> cities = await getCitiesByCountry(event.country);

        WeatherFactory wf = WeatherFactory(API_KEY, language: Language.ENGLISH);
        Map<String, Weather> weatherData = {};

        for (String city in cities) {
          Weather weather = await wf.currentWeatherByCityName(city);
          weatherData[city] = weather;
        }

        emit(CitiesWeatherSuccess(weatherData));
      } catch (e) {
        emit(CitiesWeatherFailure());
      }
    });

  }

  Future<List<String>> getCitiesByCountry(String country) async {
    // Load the JSON file
    final String response = await rootBundle.loadString('assets/city.list.json');
    final List<dynamic> data = jsonDecode(response);

    // Filter cities by the specified country
    List<String> cities = [];
    for (var item in data) {
      if (item['country'] == 'MR') {
        cities.add(item['name']);
      }
    }

    return cities;
  }
}
