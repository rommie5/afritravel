import 'package:flutter/material.dart';

class ItineraryScreen extends StatelessWidget {
  final List<String> mockItinerary = [
    'Day 1: Visit Kampala city',
    'Day 2: Safari at Murchison Falls',
    'Day 3: Relax at Ssese Islands',
  ];

   ItineraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Itinerary')),
      body: ListView.builder(
        itemCount: mockItinerary.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.check_circle_outline),
            title: Text(mockItinerary[index]),
          );
        },
      ),
    );
  }
}
