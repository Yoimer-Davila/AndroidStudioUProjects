import 'package:flutter/material.dart';
import 'package:second_flutter_challenge_application/entities.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Cities(),
    );
  }
}

void toCityTime(BuildContext context, City city, ApiService service) {
  Navigator.push(context, MaterialPageRoute(
      builder: (context) => CityTimeWidget(
          city: city,
          service: service
      )
  ));
}


class Cities extends StatefulWidget {
  const Cities({super.key});

  @override
  State<Cities> createState() => _CitiesState();
}

class _CitiesState extends State<Cities> {
  final ApiService apiService = ApiService();
  final  cities = <City>{};

  Widget buildCity(BuildContext context, dynamic json) {
    var city = City(json as String);
    var alreadySaved = cities.contains(city);
    return ListTile(
      title: Text(city.city),
      onTap: () { toCityTime(context, city, apiService); },
      trailing: IconButton(
        onPressed: ()  {
          setState(() {
            alreadySaved ? cities.remove(city) : cities.add(city);
          });
        },
        icon: Icon(
          Icons.favorite,
          color: alreadySaved ? Colors.red : null,
        ),
      ),
    );
  }

  void toFavorites() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => FavoriteCities(service: apiService, cities: cities)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('America Cities'),
        actions: <Widget>[
          IconButton(
            onPressed: toFavorites,
            icon: const Icon(Icons.list),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: apiService.fetchCities(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return buildCity(context, snapshot.data?[index]);
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class FavoriteCities extends StatelessWidget {
  final ApiService service;
  final Set<City> cities;
  const FavoriteCities({
    super.key,
    required this.service,
    required this.cities
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites words"),
      ),
      body: ListView(
        children: ListTile.divideTiles(
            tiles: cities.map((city) => ListTile(
              title: Text(
                city.city
              ),
              onTap: () { toCityTime(context, city, service); },
            )),
            context: context
        ).toList(),
      ),
    );
  }
}


class CityTimeWidget extends StatelessWidget {
  final City city;
  final ApiService service;
  const CityTimeWidget({
    super.key,
    required this.city,
    required this.service
  });

  Widget withPadding({required Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: child,
    );
  }

  Widget buildCityTime(dynamic json) {
    var cityTime = CityTime(json, city.city);
    return Card(
      elevation: 5,
      color: Colors.blueAccent,
      shadowColor: Colors.blue,
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              withPadding(
                  child: Text("Date: ${cityTime.date()}")
              ),
              withPadding(
                  child: Text("Hour: ${cityTime.time()}")
              ),
              withPadding(
                  child: Text("UTC Offset: ${cityTime.utcOffset}")
              ),
              withPadding(
                  child: Text("Timezone: ${cityTime.name}")
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${city.city} Time"),
      ),
      body: Center(
        child: FutureBuilder<dynamic>(
          future: service.fetchCityTime(city.completeCity.replaceAll("America/", "/")),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildCityTime(snapshot.data!!);
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

