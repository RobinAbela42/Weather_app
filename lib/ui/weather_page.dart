import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/services/openweathermap_api.dart';
import 'package:weather_app/ui/weather.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({
    required this.locationName,
    required this.latitude,
    required this.longitude,
    super.key,  });

  final String locationName;
  final double latitude;
  final double longitude;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    final openWeatherMapApi = Provider.of<OpenWeatherMapApi>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.locationName)),
      body: FutureBuilder<Map<String,dynamic>>(
        future: openWeatherMapApi.getWeather(widget.latitude, widget.longitude), 
        builder: (context, AsyncSnapshot<dynamic> snapshot) 
        { 

          final weatherData = snapshot.data;
          final weather = Weather.fromJson(weatherData);
          return Column(children: [
            Image.network(openWeatherMapApi.getIconUrl(weather.icon)),
            Text('${weather.condition} : ${weather.description}'),
            Text('temperature: ${weather.temperature}')
          ],);
        },
      ),
    );
  }
}