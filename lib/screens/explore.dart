import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Wildlife',
      'icon': Iconsax.tree,
      'color': const Color(0xFF4CAF50),
    },
    {
      'name': 'Adventure',
      'icon': Iconsax.activity,
      'color': const Color(0xFFFF9800),
    },
    {
      'name': 'Culture',
      'icon': Iconsax.people,
      'color': const Color(0xFF9C27B0),
    },
    {
      'name': 'Landscapes',
      'icon': Iconsax.image,
      'color': const Color(0xFF2196F3),
    },
    {
      'name': 'Relaxation',
      'icon': Iconsax.sun_1,
      'color': const Color(0xFFE91E63),
    },
  ];

  final List<Map<String, dynamic>> popularDestinations = [
    {
      'name': 'Bwindi Impenetrable Forest',
      'imageUrl': 'assets/images/Bwindi.jpg',
      'location': 'Southwestern Uganda',
      'rating': 4.9,
    },
    {
      'name': 'Murchison Falls',
      'imageUrl': 'assets/images/murcisson.jpeg',
      'location': 'Northern Uganda',
      'rating': 4.7,
    },
    {
      'name': 'Lake Bunyonyi',
      'imageUrl': 'assets/images/Lake-Bunyonyi.jpg',
      'location': 'Southwestern Uganda',
      'rating': 4.8,
    },
    {
      'name': 'Queen Elizabeth NP',
      'imageUrl': 'assets/images/elizabeth.jpeg',
      'location': 'Western Uganda',
      'rating': 4.6,
    },
  ];

  final List<Map<String, dynamic>> recentSearches = [
    {'text': 'Gorilla Trekking', 'icon': Iconsax.search_status},
    {'text': 'Nile River Rafting', 'icon': Iconsax.search_status},
    {'text': 'Kampala City Tour', 'icon': Iconsax.search_status},
    {'text': 'Sipi Falls Hiking', 'icon': Iconsax.search_status},
  ];

  String selectedCategory = 'Wildlife';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: const Color(0xFF0C3C2F),
            expandedHeight: 120,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Explore Uganda',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0C3C2F), Color(0xFF1A5E48)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search destinations, activities...',
                        prefixIcon: const Icon(Iconsax.search_normal, color: Color(0xFF0C3C2F)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Categories
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == category['name'];
                        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = category['name'];
                            });
                          },
                          child: Container(
                            width: 80,
                            margin: EdgeInsets.only(right: index == categories.length - 1 ? 0 : 12),
                            decoration: BoxDecoration(
                              color: isSelected ? category['color'] : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  category['icon'],
                                  color: isSelected ? Colors.white : category['color'],
                                  size: 28,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  category['name'],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.grey[700],
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Popular Destinations
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular Destinations',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        'View All',
                        style: TextStyle(
                          color: const Color(0xFF0C3C2F),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          
          // Popular Destinations Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.75,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final destination = popularDestinations[index];
                  
                  return DestinationCard(destination: destination);
                },
                childCount: popularDestinations.length,
              ),
            ),
          ),
          
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
          
          // Recent Searches
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Searches',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recentSearches.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final search = recentSearches[index];
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Icon(
                            search['icon'],
                            color: const Color(0xFF0C3C2F),
                          ),
                          title: Text(
                            search['text'],
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          trailing: const Icon(
                            Iconsax.arrow_right_3,
                            size: 20,
                            color: Colors.grey,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                          visualDensity: const VisualDensity(vertical: -3),
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final Map<String, dynamic> destination;

  const DestinationCard({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Show real image instead of placeholder
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              destination['imageUrl'], // ✅ always use the key 'imageUrl'
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Icon(
                      Iconsax.location,
                      size: 12,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      destination['location'],
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    Icon(
                      Iconsax.star1,
                      size: 14,
                      color: Colors.amber[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      destination['rating'].toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0C3C2F).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Explore',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0C3C2F),
                        ),
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
  }
}
