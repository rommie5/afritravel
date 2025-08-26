import 'package:flutter/material.dart';

// Main entry point of the application
void main() {
  runApp(const TourismApp());
}

// The main widget for the tourism app
class TourismApp extends StatelessWidget {
  const TourismApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tourism App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

// Data models (placed here for a single-file, runnable example)
class Place {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String location;

  const Place({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
  });
}

class Category {
  final int id;
  final String name;
  final String icon; // Icon name string, will be mapped to IconData

  const Category({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class Tour {
  final int id;
  final String name;
  final String location;
  final double rating;
  final String imageUrl;

  const Tour({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
  });
}

class Event {
  final int id;
  final String name;
  final String location;
  final String date;
  final String imageUrl;

  const Event({
    required this.id,
    required this.name,
    required this.location,
    required this.date,
    required this.imageUrl,
  });
}

// Helper function to map icon names to IconData
IconData? getIconData(String iconName) {
  switch (iconName) {
    case 'landscape':
      return Icons.landscape;
    case 'local_activity':
      return Icons.local_activity;
    case 'restaurant':
      return Icons.restaurant;
    case 'history_edu':
      return Icons.history_edu;
    case 'nightlife':
      return Icons.nightlife;
    default:
      return null;
  }
}

// The home screen of the app
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Sample data
  final List<Place> places = [
    const Place(
        id: 1,
        name: 'Bwindi',
        description: 'Rainforest & Gorillas',
        imageUrl: 'assets/images/bwindi.jpeg',
        location: 'Uganda'),
    const Place(
        id: 2,
        name: 'Murchison Falls',
        description: 'Waterfall & Wildlife',
        imageUrl: 'assets/images/murcisson.jpeg',
        location: 'Uganda'),
    const Place(
        id: 3,
        name: 'Ssese Islands',
        description: 'Beach Paradise',
        imageUrl: 'assets/images/ssesse.jpg',
        location: 'Uganda'),
  ];

  final List<Category> categories = [
    const Category(id: 1, name: 'Nature', icon: 'landscape'),
    const Category(id: 2, name: 'Adventure', icon: 'local_activity'),
    const Category(id: 3, name: 'Food', icon: 'restaurant'),
    const Category(id: 4, name: 'Culture', icon: 'history_edu'),
    const Category(id: 5, name: 'Nightlife', icon: 'nightlife'),
  ];

  final List<Tour> trendingTours = [
    const Tour(
        id: 1,
        name: 'Kidepo Valley',
        location: 'Uganda',
        rating: 4.8,
        imageUrl: 'assets/images/kidepo.jpeg'),
    const Tour(
        id: 2,
        name: 'Lake Bunyonyi',
        location: 'Uganda',
        rating: 4.6,
        imageUrl: 'assets/images/Lake-Bunyonyi.jpg'),
    const Tour(
        id: 3,
        name: 'Rwenzori Mountains',
        location: 'Uganda',
        rating: 4.7,
        imageUrl: 'assets/images/rwenzori.jpeg'),
  ];

  final List<Event> events = [
    const Event(
        id: 1,
        name: 'Imbalu Festival',
        location: 'Mbale',
        date: 'Aug 25',
        imageUrl: 'assets/images/imbalu.jpeg'),
    const Event(
        id: 2,
        name: 'New Year Safari',
        location: 'Kampala',
        date: 'Dec 31',
        imageUrl: 'assets/images/new.jpeg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // ===== Bottom Navigation =====
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== HERO SECTION =====
              Stack(
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/ssesse.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 220,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.3),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Explore Uganda',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('Explore Now'),
                        )
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ===== FEATURED DESTINATIONS =====
              sectionTitle('Featured Destinations'),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: places.length,
                  itemBuilder: (context, index) {
                    final place = places[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PlaceDetailScreen(place: place)),
                        );
                      },
                      child: destinationCard(
                          place.name, place.description, place.imageUrl),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Categories
              sectionTitle('Categories'),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final cat = categories[index];
                    return categoryCard(getIconData(cat.icon), cat.name);
                  },
                ),
              ),

              const SizedBox(height: 20),

              // trending tours
              sectionTitle('Trending Tours'),
              Column(
                children: trendingTours.map((tour) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TourDetailScreen(tour: tour)),
                      );
                    },
                    child: trendingTourCard(
                        tour.name, tour.location, tour.rating, tour.imageUrl),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              //upcoming events
              sectionTitle('Upcoming Festivals & Events'),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EventDetailScreen(event: event)),
                        );
                      },
                      child: eventCard(
                          event.name, event.location, event.date, event.imageUrl),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper Widgets (moved outside the HomeScreen class for clarity)

Widget sectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}

Widget destinationCard(String title, String subtitle, String imagePath) {
  return Container(
    width: 140,
    margin: const EdgeInsets.only(right: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text(subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    ),
  );
}

Widget categoryCard(IconData? icon, String label) {
  return Container(
    width: 80,
    margin: const EdgeInsets.only(right: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: const LinearGradient(
        colors: [Colors.orangeAccent, Colors.deepOrange],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    ),
  );
}

Widget trendingTourCard(
    String name, String location, double rating, String imagePath) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(name),
      subtitle: Text('$location • ⭐ $rating'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    ),
  );
}

Widget eventCard(String name, String location, String date, String imagePath) {
  return Container(
    width: 180,
    margin: const EdgeInsets.only(right: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Colors.black.withOpacity(0.7), Colors.transparent],
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            Text('$location • $date',
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ],
        ),
      ),
    ),
  );
}

// Detail screens for each type of data
class PlaceDetailScreen extends StatelessWidget {
  final Place place;
  const PlaceDetailScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'place-image-${place.id}',
                  child: Image.asset(
                    place.imageUrl,
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                        Colors.white
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    place.location,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description:',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    place.description,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 20),
                  // Add more details here like a map or more info
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Book a Tour'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TourDetailScreen extends StatelessWidget {
  final Tour tour;
  const TourDetailScreen({super.key, required this.tour});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tour.name),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                tour.imageUrl,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                tour.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Location: ${tour.location}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Rating: ⭐ ${tour.rating}',
                style: const TextStyle(fontSize: 18, color: Colors.amber),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventDetailScreen extends StatelessWidget {
  final Event event;
  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                event.imageUrl,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                event.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Location: ${event.location}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Date: ${event.date}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
