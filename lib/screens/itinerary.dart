import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({super.key});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  int _selectedTab = 0;
  final List<Map<String, dynamic>> _myItineraries = [
    {
      'id': '1',
      'title': '7-Day Wildlife Adventure',
      'duration': '7 days, 6 nights',
      'destinations': ['Bwindi', 'Queen Elizabeth', 'Murchison Falls'],
      'image': 'assets/wildlife.jpg',
      'startDate': 'Oct 15, 2024',
      'endDate': 'Oct 21, 2024',
      'status': 'Upcoming',
      'progress': 0.3,
      'activities': 12,
      'budget': '\$2,500',
    },
    {
      'id': '2',
      'title': 'Weekend Gorilla Trekking',
      'duration': '3 days, 2 nights',
      'destinations': ['Bwindi Forest'],
      'image': 'assets/gorilla.jpg',
      'startDate': 'Sep 20, 2024',
      'endDate': 'Sep 22, 2024',
      'status': 'Completed',
      'progress': 1.0,
      'activities': 4,
      'budget': '\$1,200',
    },
  ];

  final List<Map<String, dynamic>> _suggestedItineraries = [
    {
      'id': '3',
      'title': 'Cultural Heritage Tour',
      'duration': '5 days, 4 nights',
      'destinations': ['Kampala', 'Jinja', 'Mbale'],
      'image': 'assets/cultural.jpg',
      'rating': 4.8,
      'saves': 234,
      'activities': 8,
      'price': '\$1,800',
    },
    {
      'id': '4',
      'title': 'Adventure Seekers Package',
      'duration': '4 days, 3 nights',
      'destinations': ['Jinja', 'Sipi Falls'],
      'image': 'assets/adventure.jpg',
      'rating': 4.6,
      'saves': 189,
      'activities': 6,
      'price': '\$950',
    },
    {
      'id': '5',
      'title': 'Luxury Safari Experience',
      'duration': '8 days, 7 nights',
      'destinations': ['Murchison Falls', 'Queen Elizabeth', 'Lake Mburo'],
      'image': 'assets/luxury.jpg',
      'rating': 4.9,
      'saves': 156,
      'activities': 15,
      'price': '\$3,500',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xFF0C3C2F),
            expandedHeight: 140,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'My Itineraries',
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
            actions: [
              IconButton(
                icon: Icon(Iconsax.add, color: Colors.white),
                onPressed: _createNewItinerary,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Tab Selection
                  Container(
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
                        _buildTabButton('My Plans', 0),
                        _buildTabButton('Suggested', 1),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
          // Content based on selected tab
          _selectedTab == 0 ? _buildMyItineraries() : _buildSuggestedItineraries(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewItinerary,
        backgroundColor: Color(0xFF0C3C2F),
        child: Icon(Iconsax.add, color: Colors.white, size: 28),
        shape: RoundedRectangleBorder(),
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF0C3C2F) : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyItineraries() {
    if (_myItineraries.isEmpty) {
      return SliverFillRemaining(
        child: _buildEmptyState(
          icon: Iconsax.calendar,
          title: 'No Itineraries Yet',
          subtitle: 'Start planning your Uganda adventure by creating your first itinerary',
          buttonText: 'Create Itinerary',
          onPressed: _createNewItinerary,
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final itinerary = _myItineraries[index];
          return _buildMyItineraryCard(itinerary, index);
        },
        childCount: _myItineraries.length,
      ),
    );
  }

  Widget _buildSuggestedItineraries() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final itinerary = _suggestedItineraries[index];
          return _buildSuggestedItineraryCard(itinerary, index);
        },
        childCount: _suggestedItineraries.length,
      ),
    );
  }

  Widget _buildMyItineraryCard(Map<String, dynamic> itinerary, int index) {
    final isCompleted = itinerary['status'] == 'Completed';
    
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
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
          // Image Header
          Stack(
            children: [
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Iconsax.image,
                    size: 40,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isCompleted ? Colors.green : Color(0xFFFF9800),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    itinerary['status'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        itinerary['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Iconsax.more, size: 20),
                      onPressed: () => _showItineraryOptions(itinerary),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                
                // Dates and Duration
                Row(
                  children: [
                    Icon(Iconsax.calendar, size: 14, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      '${itinerary['startDate']} - ${itinerary['endDate']}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    SizedBox(width: 16),
                    Icon(Iconsax.clock, size: 14, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      itinerary['duration'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                
                // Destinations
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: itinerary['destinations'].map<Widget>((destination) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF0C3C2F).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        destination,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF0C3C2F),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                
                // Progress and Stats
                if (!isCompleted) _buildProgressBar(itinerary['progress']),
                SizedBox(height: 12),
                
                Row(
                  children: [
                    _buildStatChip(Iconsax.activity, '${itinerary['activities']} Activities'),
                    SizedBox(width: 12),
                    _buildStatChip(Iconsax.wallet, itinerary['budget']),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () => _viewItineraryDetails(itinerary),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0C3C2F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                      child: Text(
                        isCompleted ? 'View Again' : 'Continue',
                        style: TextStyle(fontWeight: FontWeight.w600),
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

  Widget _buildSuggestedItineraryCard(Map<String, dynamic> itinerary, int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16),
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
          // Image Header
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Center(
              child: Icon(
                Iconsax.image,
                size: 40,
                color: Colors.grey[400],
              ),
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itinerary['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 8),
                
                // Rating and Saves
                Row(
                  children: [
                    Icon(Iconsax.star1, size: 14, color: Colors.amber),
                    SizedBox(width: 4),
                    Text(
                      itinerary['rating'].toString(),
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 16),
                    Icon(Iconsax.heart, size: 14, color: Colors.red),
                    SizedBox(width: 4),
                    Text(
                      '${itinerary['saves']} saves',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                
                // Duration and Activities
                Row(
                  children: [
                    Icon(Iconsax.clock, size: 14, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      itinerary['duration'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    SizedBox(width: 16),
                    Icon(Iconsax.activity, size: 14, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      '${itinerary['activities']} activities',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                
                // Destinations
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: itinerary['destinations'].map<Widget>((destination) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF0C3C2F).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        destination,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF0C3C2F),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                
                // Price and Action Button
                Row(
                  children: [
                    Text(
                      itinerary['price'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFF0C3C2F),
                      ),
                    ),
                    Spacer(),
                    OutlinedButton(
                      onPressed: () => _saveItinerary(itinerary),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: Color(0xFF0C3C2F)),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Color(0xFF0C3C2F)),
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _useItinerary(itinerary),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0C3C2F),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Use This Plan'),
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

  Widget _buildProgressBar(double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Planning Progress',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 4),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          color: Color(0xFF0C3C2F),
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
        SizedBox(height: 4),
        Text(
          '${(progress * 100).toInt()}% complete',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[500],
          ),
        ),
      ],
    );
  }

  Widget _buildStatChip(IconData icon, String text) {
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

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
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
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0C3C2F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text(
                buttonText,
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

  void _createNewItinerary() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create New Itinerary',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Itinerary Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Duration (days)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigate to itinerary builder
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0C3C2F),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('Create Itinerary'),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _viewItineraryDetails(Map<String, dynamic> itinerary) {
    // Navigate to itinerary detail screen
  }

  void _showItineraryOptions(Map<String, dynamic> itinerary) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Iconsax.edit),
                title: Text('Edit Itinerary'),
                onTap: () {
                  Navigator.pop(context);
                  // Edit itinerary
                },
              ),
              ListTile(
                leading: Icon(Iconsax.copy),
                title: Text('Duplicate'),
                onTap: () {
                  Navigator.pop(context);
                  // Duplicate itinerary
                },
              ),
              ListTile(
                leading: Icon(Iconsax.share),
                title: Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                  // Share itinerary
                },
              ),
              ListTile(
                leading: Icon(Iconsax.trash, color: Colors.red),
                title: Text('Delete', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  // Delete itinerary
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveItinerary(Map<String, dynamic> itinerary) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved to your favourites'),
        backgroundColor: Color(0xFF0C3C2F),
      ),
    );
  }

  void _useItinerary(Map<String, dynamic> itinerary) {
    // Add to my itineraries and navigate to edit
  }
}