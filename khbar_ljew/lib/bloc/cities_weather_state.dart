part of 'cities_weather_bloc.dart';

sealed class CitiesWeatherState extends Equatable {
  const CitiesWeatherState();
  
  @override
  List<Object> get props => [];
}

final class CitiesWeatherInitial extends CitiesWeatherState {}
final class CitiesWeatherLoading extends CitiesWeatherState {}
final class CitiesWeatherFailure extends CitiesWeatherState {}
final class CitiesWeatherSuccess extends CitiesWeatherState {
  final Map<String, Weather> weatherData;

  const CitiesWeatherSuccess(this.weatherData);

  @override
  List<Object> get props => [weatherData];
}
