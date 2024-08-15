import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';

class CityWeatherDetailScreen extends StatelessWidget {
  final String cityName;
  final Weather weather;

  const CityWeatherDetailScreen({
    Key? key,
    required this.cityName,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 600,
                  width: 600,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(color: Colors.grey),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                        icon: const Icon(Icons.arrow_back,color: Colors.white,),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),Text(
                      cityName,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 186, 203, 217),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                      ],
                     ),
                    
                    const SizedBox(height: 20),
                    Text(
                      _getGreeting(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Image.asset(
                        _getWeatherIcon(weather.weatherConditionCode!),
                        height: 200,
                      ),
                    ),
                    Center(
                      child: Text(
                        '${weather.temperature?.celsius?.toStringAsFixed(1)} °C',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        weather.weatherMain?.toUpperCase() ?? 'Unknown',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 35, letterSpacing: 3),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Center(
                      child: Text(
                        DateFormat('EEEE dd • ').add_jm().format(weather.date!),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w100),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/sun.png', scale: 8),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sunrise',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  _formatTime(weather.sunrise!),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset('assets/moon.png', scale: 8),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Sunset',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  _formatTime(weather.sunset!),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/high-temperature.png', scale: 8),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Temp Max',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  '${weather.tempMax?.celsius?.round()} °C',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset('assets/thermometer.png', scale: 8),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Temp Min',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  '${weather.tempMin?.celsius?.round()} °C',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/windmill.png', scale: 8),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Wind speed (m/s)',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  '${weather.windSpeed}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Text(
                                  'Wind Degree',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  '${weather.windDegree} °',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset('assets/humidity.png', scale: 8),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Humidity',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  '${weather.humidity?.round()} %',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getWeatherIcon(int code) {
    switch (code) {
      case 200: // Example for Thunderstorm, update as necessary
        return 'assets/thunderstorm.png';
      case 300: // Example for Rainy, update as necessary
        return 'assets/rainy-day.png';
      case 600: // Example for Snow, update as necessary
        return 'assets/snow.png';
      case 800: // Example for Clear, update as necessary
        return 'assets/sun.png';
      default:
        return 'assets/clouds.png';
    }
  }

  String _formatTime(DateTime time) {
    return DateFormat('jm').format(time); // Format to 12-hour time
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) return 'Good Morning';
    if (hour >= 12 && hour < 17) return 'Good Afternoon';
    if (hour >= 17 && hour < 21) return 'Good Evening';
    return 'Good Night';
  }
}
