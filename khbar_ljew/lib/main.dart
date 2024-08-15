import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:khbar_ljew/bloc/cities_weather_bloc.dart';
import 'package:khbar_ljew/bloc/weather_bloc.dart';
import 'package:khbar_ljew/screens/home_screen.dart';
import 'package:khbar_ljew/screens/weather%20detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: _determinePosition(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        if (snap.hasError) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(child: Text('Error determining location')),
            ),
          );
        }

        return MultiBlocProvider(
          providers: [
            BlocProvider<WeatherBloc>(
              create: (context) => WeatherBloc()
                ..add(FetchWeather(snap.data!)),
            ),
            BlocProvider<CitiesWeatherBloc>(
              create: (context) => CitiesWeatherBloc(),
            ),
          ],
          child: const MyHomePage(),
        );
      },
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.',
    );
  }

  return await Geolocator.getCurrentPosition();
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget selectedScreen;
    switch (_selectedIndex) {
      case 0:
        selectedScreen = const HomeScreen();
        break;
      case 1:
        selectedScreen = const WeatherDetail();
        break;
      default:
        selectedScreen = const HomeScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: selectedScreen,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Cities List',
            ),
          ],
        ),
      ),
    );
  }
}
