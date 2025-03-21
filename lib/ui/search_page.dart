import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/openweathermap_api.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final openWeatherMapApi = context.read<OpenWeatherMapApi>();

    return Scaffold(
      appBar: AppBar(title: const Text('Recherche')),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              query = value.trim();
            },
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                openWeatherMapApi.searchLocations(query);
              });
            },
            child: Text("Rechercher"),
          ),
          FutureBuilder(
            future: openWeatherMapApi.searchLocations(query),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Une erreur est survenue.\n${snapshot.error}');
              }

              if (!snapshot.hasData) {
                return const Text('Aucun résultat pour cette recherche.');
              }

              return Column(
                children: [
                  for (final location in snapshot.data!)
                    ListTile(
                      title: Text("${location.name} (${location.country})"),
                      subtitle: Text(
                        "${location.lat} lat, ${location.lon} lon",
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
