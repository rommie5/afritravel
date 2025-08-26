import 'package:flutter/material.dart';
import '../models/place.dart';
import '../models/category.dart';
import '../models/tour.dart';
import '../models/event.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final List<Place> places =  [
    Place(
        id: 1,
        name: 'Bwindi',
        description: 'Rainforest & Gorillas',
        imageUrl: 'assets/images/bwindi.jpeg',
        location: 'Uganda'),
    Place(
        id: 2,
        name: 'Murchison Falls',
        description: 'Waterfall & Wildlife',
        imageUrl: 'assets/images/murcisson.jpeg',
        location: 'Uganda'),
    Place(
        id: 3,
        name: 'Ssese Islands',
        description: 'Beach Paradise',
        imageUrl: 'assets/images/ssesse.jpg',
        location: 'Uganda'),
  ];

  final List<Category> categories =  [
    Category(id: 1, name: 'Nature', icon: 'landscape'),
    Category(id: 2, name: 'Adventure', icon: 'local_activity'),
    Category(id: 3, name: 'Food', icon: 'restaurant'),
    Category(id: 4, name: 'Culture', icon: 'history_edu'),
    Category(id: 5, name: 'Nightlife', icon: 'nightlife'),
  ];

  final List<Tour> trendingTours = [
  Tour(
      id: 1,
      name: 'Kidepo Valley',
      location: 'Uganda',
      rating: 4.8,
      imageUrl: 'assets/images/kidepo.jpeg'), 
  Tour(
      id: 2,
      name: 'Lake Bunyonyi',
      location: 'Uganda',
      rating: 4.6,
      imageUrl: 'assets/images/Lake-Bunyonyi.jpg'), 
  Tour(
      id: 3,
      name: 'Rwenzori Mountains',
      location: 'Uganda',
      rating: 4.7,
      imageUrl: 'assets/images/rwenzori.jpeg'), 
];


  final List<Event> events = [
  Event(
      id: 1,
      name: 'Imbalu Festival',
      location: 'Mbale',
      date: 'Aug 25',
      imageUrl: 'assets/images/imbalu.jpeg'), 
  Event(
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
                    return destinationCard(
                        place.name, place.description, place.imageUrl);
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
                    return categoryCard(cat.iconData, cat.name);
                  },
                ),
              ),

              const SizedBox(height: 20),

// trending tours
              sectionTitle('Trending Tours'),
              Column(
                children: trendingTours
                    .map((tour) =>
                        trendingTourCard(tour.name, tour.location, tour.rating, tour.imageUrl))
                    .toList(),
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
                    return eventCard(
                        event.name, event.location, event.date, event.imageUrl);
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

  // widget helpers

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

  Widget categoryCard(IconData icon, String label) {
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

  Widget trendingTourCard(String name, String location, double rating, String imagePath) {
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
        onTap: () {},
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
}
