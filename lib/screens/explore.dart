import 'package:flutter/material.dart';
import '../services/api.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<dynamic> places = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchPlaces();
  }

  void fetchPlaces() async {
    try {
      final data = await ApiService.getPlaces();
      setState(() {
        places = data;
        loading = false;
      });
    } catch (e) {
      print(e);
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explore Places')),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(place['name']),
                    subtitle: Text(place['description']),
                  ),
                );
              },
            ),
    );
  }
}
