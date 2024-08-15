import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khbar_ljew/bloc/cities_weather_bloc.dart';
import 'package:khbar_ljew/screens/city_weather_detail_screen.dart';
import 'package:weather/weather.dart';

class WeatherDetail extends StatefulWidget {
  const WeatherDetail({super.key});

  @override
  State<WeatherDetail> createState() => _WeatherDetailState();
}

class _WeatherDetailState extends State<WeatherDetail> {
  @override
  void initState() {
    super.initState();
    // Fetch weather for Mauritania when the screen is initialized
    context.read<CitiesWeatherBloc>().add(FetchWeatherByCountry('Mauritania'));
  }

  // Function to get a gradient based on temperature
  LinearGradient getGradient(double temperature) {
    // Define color ranges based on temperature
    Color startColor;
    Color endColor;

    if (temperature < 16) {
      startColor = Colors.blue[400]!;
      endColor = Colors.blue[800]!;
    } else if (temperature < 26) {
      startColor = Colors.lightBlue[200]!;
      endColor = Colors.blue[600]!;
    } else if (temperature < 30) {
      startColor = Colors.yellow[200]!;
      endColor = Colors.orange[400]!;
    } else if (temperature < 35) {
      startColor = Colors.orange[200]!;
      endColor = Colors.red[400]!;
    } else {
      startColor = Colors.red[200]!;
      endColor = Colors.red[800]!;
    }

    return LinearGradient(
      colors: [startColor, endColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather in Mauritania'),
      ),
      body: BlocBuilder<CitiesWeatherBloc, CitiesWeatherState>(
        builder: (context, state) {
          if (state is CitiesWeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CitiesWeatherSuccess) {
            return ListView.builder(
              itemCount: state.weatherData.length,
              itemBuilder: (context, index) {
                String city = state.weatherData.keys.elementAt(index);
                Weather weather = state.weatherData[city]!;

                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    gradient: getGradient(weather.temperature!.celsius!),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      city,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    subtitle: Text(
                      '${weather.temperature?.celsius?.toStringAsFixed(1)} °C',
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CityWeatherDetailScreen(
                            cityName: city,
                            weather: weather,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is CitiesWeatherFailure) {
            return const Center(child: Text('Failed to fetch weather data.'));
          } else {
            return const Center(child: Text('No weather data available.'));
          }
        },
      ),
    );
  }
}
