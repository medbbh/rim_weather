part of 'cities_weather_bloc.dart';

sealed class CitiesWeatherEvent extends Equatable {
  const CitiesWeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeatherByCountry extends CitiesWeatherEvent {
  final String country;

  const FetchWeatherByCountry(this.country);

  @override
  List<Object> get props => [country];
}