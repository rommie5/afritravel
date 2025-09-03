//help me use the bottom navigation bar
import 'package:afri_travel/screens/explore.dart';
import 'package:afri_travel/screens/uploads.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

final List<Map<String, dynamic>> _featuredDestinations = [
  {
    'name': 'Bwindi Impenetrable ',
    'imageUrl': 'assets/images/Bwindi.jpg',
    'location': 'Southwestern Uganda',
    'rating': 4.9,
    'type': 'Wildlife',
  },
  {
    'name': 'Murchison Falls',
    'imageUrl': 'assets/images/murcisson.jpeg',
    'location': 'Northern Uganda',
    'rating': 4.7,
    'type': 'Adventure',
  },
  {
    'name': 'Lake Bunyonyi',
    'imageUrl': 'assets/images/Lake-Bunyonyi.jpg',
    'location': 'Southwestern Uganda',
    'rating': 4.8,
    'type': 'Relaxation',
  },
];


  final List<Map<String, dynamic>> _popularActivities = [
    {
      'name': 'Gorilla Trekking',
      'icon': Iconsax.tree,
      'color': Color(0xFF4CAF50),
    },
    {
      'name': 'White Water Rafting',
      'icon': Iconsax.layer,
      'color': Color(0xFF2196F3),
    },
    {
      'name': 'Safari Tour',
      'icon': Iconsax.camera,
      'color': Color(0xFFFF9800),
    },
    {
      'name': 'Cultural Experience',
      'icon': Iconsax.music,
      'color': Color(0xFF9C27B0),
    },
  ];

  final List<Map<String, dynamic>> _travelTips = [
    {
      'title': 'Best Time to Visit',
      'description': 'Learn about the ideal seasons for wildlife viewing',
      'icon': Iconsax.calendar,
    },
    {
      'title': 'Travel Requirements',
      'description': 'Visa and health information for visitors',
      'icon': Iconsax.document,
    },
    {
      'title': 'Local Customs',
      'description': 'Cultural etiquette and traditions',
      'icon': Iconsax.people,
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          // App Bar with User Info
          SliverAppBar(
            backgroundColor: Color(0xFF0C3C2F),
            expandedHeight: 120,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Discover Uganda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
            actions: [
              IconButton(
                icon: Icon(Iconsax.notification, color: Colors.white),
                onPressed: () {
                  // Handle notification tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExploreScreen(),
                    ),
                  );
                },
              ),
            ],
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Welcome Message
                  _buildWelcomeSection(),
                  SizedBox(height: 24),

                  // Search Bar
                  _buildSearchBar(),
                  SizedBox(height: 24),

                  // Banner Carousel
                  _buildBannerCarousel(),
                  SizedBox(height: 24),

                  // Quick Categories
                  _buildQuickCategories(),
                  SizedBox(height: 24),

                  // Featured Destinations
                  _buildFeaturedDestinations(),
                  SizedBox(height: 24),

                  // Popular Activities
                  _buildPopularActivities(),
                  SizedBox(height: 24),

                  // Travel Tips
                  _buildTravelTips(),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to Uganda,',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4),
        Text(
          'The Pearl of Africa!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0C3C2F),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search destinations, activities...',
          prefixIcon: Icon(Iconsax.search_normal, color: Color(0xFF0C3C2F)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [Color(0xFF0C3C2F), Color(0xFF2E8B57)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50,
            bottom: -20,
            child: Icon(
              Iconsax.tree,
              size: 150,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gorilla Trekking Adventure',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Experience the magic of meeting\nmountain gorillas in their natural habitat',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.1,
                  ),
                ),
                SizedBox(height: 14),
             InkWell(
  // The onTap callback is where you define the navigation logic
  onTap: () {
    // Use Navigator to push the new page onto the stack
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UploadDestinationPage()), // Replace YourNewPage with the actual page widget
    );
  },
  // It's good practice to clip the ripple effect to the container's shape
  borderRadius: BorderRadius.circular(20), 
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Text(
      'Book Now',
      style: TextStyle(
        color: Color(0xFF0C3C2F),
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCategoryButton('Wildlife', Iconsax.tree, Color(0xFF4CAF50)),
            _buildCategoryButton('Adventure', Iconsax.activity, Color(0xFFFF9800)),
            _buildCategoryButton('Culture', Iconsax.people, Color(0xFF9C27B0)),
            _buildCategoryButton('Relax', Iconsax.sun_1, Color(0xFF2196F3)),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryButton(String title, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

 Widget _buildFeaturedDestinations() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Featured Destinations',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          Text(
            'View All',
            style: TextStyle(
              color: Color(0xFF0C3C2F),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      SizedBox(height: 12),
      SizedBox(
        height: 240,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _featuredDestinations.length,
          itemBuilder: (context, index) {
            final destination = _featuredDestinations[index];
            return Container(
              width: 200,
              margin: EdgeInsets.only(right: 16),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      destination['imageUrl'], 
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          destination['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Iconsax.location,
                              size: 12,
                              color: Colors.grey[600],
                            ),
                            SizedBox(width: 4),
                            Text(
                              destination['location'],
                              style: TextStyle(
                                fontSize: 11,
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
                                color: destination['type'] == 'Wildlife'
                                    ? Color(0xFF4CAF50).withOpacity(0.1)
                                    : destination['type'] == 'Adventure'
                                        ? Color(0xFFFF9800).withOpacity(0.1)
                                        : Color(0xFF2196F3).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                destination['type'],
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: destination['type'] == 'Wildlife'
                                      ? Color(0xFF4CAF50)
                                      : destination['type'] == 'Adventure'
                                          ? Color(0xFFFF9800)
                                          : Color(0xFF2196F3),
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
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  );
}


  Widget _buildPopularActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Popular Activities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            Text(
              'See All',
              style: TextStyle(
                color: Color(0xFF0C3C2F),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 2.5,
          ),
          itemCount: _popularActivities.length,
          itemBuilder: (context, index) {
            final activity = _popularActivities[index];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    decoration: BoxDecoration(
                      color: activity['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                    ),
                    child: Icon(activity['icon'], color: activity['color']),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      activity['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTravelTips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Travel Tips',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 12),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _travelTips.length,
          itemBuilder: (context, index) {
            final tip = _travelTips[index];
            return Container(
              margin: EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF0C3C2F).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(tip['icon'], color: Color(0xFF0C3C2F)),
                ),
                title: Text(
                  tip['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  tip['description'],
                  style: TextStyle(fontSize: 12),
                ),
                trailing: Icon(Iconsax.arrow_right_3, size: 20),
              ),
            );
          },
        ),
      ],
    );
  }
}