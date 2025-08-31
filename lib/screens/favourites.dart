import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Map<String, dynamic>> _savedDestinations = [
    {
      'name': 'Bwindi Impenetrable Forest',
      'imageUrl': 'assets/images/bwindi.jpeg',
      'location': 'Southwestern Uganda',
      'rating': 4.9,
      'type': 'Wildlife',
      'price': '\$700',
      'isLiked': true,
    },
    {
      'name': 'Murchison Falls',
      'imageUrl': 'assets/images/murcisson.jpeg',
      'location': 'Northern Uganda',
      'rating': 4.7,
      'type': 'Adventure',
      'price': '\$350',
      'isLiked': true,
    },
    {
      'name': 'Lake Bunyonyi',
      'imageUrl': 'assets/images/Lake-Bunyonyi.jpg',
      'location': 'Southwestern Uganda',
      'rating': 4.8,
      'type': 'Relaxation',
      'price': '\$250',
      'isLiked': true,
    },
  ];

  final List<Map<String, dynamic>> _savedActivities = [
    {
      'name': 'Gorilla Trekking',
      'location': 'Bwindi Forest',
      'duration': '4 hours',
      'difficulty': 'Moderate',
      'price': '\$700',
      'isLiked': true,
    },
    {
      'name': 'White Water Rafting',
      'location': 'Nile River',
      'duration': 'Full day',
      'difficulty': 'Extreme',
      'price': '\$120',
      'isLiked': true,
    },
    {
      'name': 'Cultural Village Tour',
      'location': 'Kampala',
      'duration': '3 hours',
      'difficulty': 'Easy',
      'price': '\$50',
      'isLiked': true,
    },
  ];

  final List<Map<String, dynamic>> _savedItineraries = [
    {
      'title': '7-Day Wildlife Adventure',
      'destinations': 4,
      'days': 7,
      'saved': 124,
      'isLiked': true,
    },
    {
      'title': 'Weekend Getaway to Nature',
      'destinations': 2,
      'days': 3,
      'saved': 89,
      'isLiked': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Color(0xFF0C3C2F),
              expandedHeight: 140,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  'My Favourites',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                centerTitle: true,
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0C3C2F), Color(0xFF1A5E48)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  indicatorColor: Color(0xFF0C3C2F),
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelColor: Color(0xFF0C3C2F),
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  tabs: [
                    Tab(text: 'Destinations'),
                    Tab(text: 'Activities'),
                    Tab(text: 'Itineraries'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Destinations Tab
            _buildDestinationsTab(),
            
            // Activities Tab
            _buildActivitiesTab(),
            
            // Itineraries Tab
            _buildItinerariesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildDestinationsTab() {
    if (_savedDestinations.isEmpty) {
      return _buildEmptyState(
        icon: Iconsax.location,
        title: 'No Saved Destinations',
        subtitle: 'Start exploring and save your favorite places to visit in Uganda',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _savedDestinations.length,
      itemBuilder: (context, index) {
        final destination = _savedDestinations[index];
        return _buildDestinationCard(destination, index);
      },
    );
  }

  Widget _buildActivitiesTab() {
    if (_savedActivities.isEmpty) {
      return _buildEmptyState(
        icon: Iconsax.activity,
        title: 'No Saved Activities',
        subtitle: 'Save exciting activities you want to experience in Uganda',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _savedActivities.length,
      itemBuilder: (context, index) {
        final activity = _savedActivities[index];
        return _buildActivityCard(activity, index);
      },
    );
  }

  Widget _buildItinerariesTab() {
    if (_savedItineraries.isEmpty) {
      return _buildEmptyState(
        icon: Iconsax.calendar,
        title: 'No Saved Itineraries',
        subtitle: 'Save pre-made itineraries for your perfect Uganda adventure',
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _savedItineraries.length,
      itemBuilder: (context, index) {
        final itinerary = _savedItineraries[index];
        return _buildItineraryCard(itinerary, index);
      },
    );
  }

  Widget _buildDestinationCard(Map<String, dynamic> destination, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Image section
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
            child: Image.asset(
              destination['imageUrl'],
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 140,
                  color: Colors.grey[200],
                  child: Center(
                    child: Icon(Iconsax.image, size: 40, color: Colors.grey[400]),
                  ),
                );
                        },
                      ),
                    ),

              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    destination['price'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0C3C2F),
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Content section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Iconsax.location,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          SizedBox(width: 4),
                          Text(
                            destination['location'],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(destination['type']).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              destination['type'],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: _getCategoryColor(destination['type']),
                              ),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Iconsax.star1,
                            size: 14,
                            color: Colors.amber[600],
                          ),
                          SizedBox(width: 4),
                          Text(
                            destination['rating'].toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                IconButton(
                  icon: Icon(
                    destination['isLiked'] ? Iconsax.heart5 : Iconsax.heart,
                    color: destination['isLiked'] ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _savedDestinations.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Removed from favourites'),
                        backgroundColor: Color(0xFF0C3C2F),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF0C3C2F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Iconsax.activity,
                color: Color(0xFF0C3C2F),
                size: 28,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    activity['location'],
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      _buildActivityChip(
                        Iconsax.clock,
                        activity['duration'],
                      ),
                      SizedBox(width: 8),
                      _buildActivityChip(
                        Iconsax.game,
                        activity['difficulty'],
                      ),
                      Spacer(),
                      Text(
                        activity['price'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0C3C2F),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            IconButton(
              icon: Icon(
                activity['isLiked'] ? Iconsax.heart5 : Iconsax.heart,
                color: activity['isLiked'] ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _savedActivities.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Removed from favourites'),
                    backgroundColor: Color(0xFF0C3C2F),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItineraryCard(Map<String, dynamic> itinerary, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xFF0C3C2F).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Iconsax.calendar_1,
                    color: Color(0xFF0C3C2F),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    itinerary['title'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    itinerary['isLiked'] ? Iconsax.heart5 : Iconsax.heart,
                    color: itinerary['isLiked'] ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _savedItineraries.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Removed from favourites'),
                        backgroundColor: Color(0xFF0C3C2F),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                _buildItineraryChip(
                  '${itinerary['destinations']} Destinations',
                  Iconsax.location,
                ),
                SizedBox(width: 8),
                _buildItineraryChip(
                  '${itinerary['days']} Days',
                  Iconsax.clock,
                ),
                Spacer(),
                _buildItineraryChip(
                  '${itinerary['saved']} Saved',
                  Iconsax.heart,
                ),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0C3C2F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'View Itinerary',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey[600]),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItineraryChip(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.grey[600]),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({required IconData icon, required String title, required String subtitle}) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xFF0C3C2F).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: Color(0xFF0C3C2F),
              ),
            ),
            SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate to explore screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0C3C2F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                'Start Exploring',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String type) {
    switch (type) {
      case 'Wildlife':
        return Color(0xFF4CAF50);
      case 'Adventure':
        return Color(0xFFFF9800);
      case 'Relaxation':
        return Color(0xFF2196F3);
      default:
        return Color(0xFF9C27B0);
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}