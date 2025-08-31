import 'package:afri_travel/screens/explore.dart';
import 'package:afri_travel/screens/favourites.dart';
import 'package:afri_travel/screens/home1.dart';
import 'package:afri_travel/screens/itinerary.dart';
import 'package:afri_travel/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  // List of screens for navigation
  final List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    FavouritesScreen(),
    ItineraryScreen(),
    ProfileScreen(),
  ];

  // Bottom navigation items
  final List<BottomNavigationItem> _navItems = [
    BottomNavigationItem(
      icon: Iconsax.home,
      activeIcon: Iconsax.home_15,
      label: 'Home',
    ),
    BottomNavigationItem(
      icon: Iconsax.discover,
      activeIcon: Iconsax.discover_14,
      label: 'Explore',
    ),
    BottomNavigationItem(
      icon: Iconsax.heart,
      activeIcon: Iconsax.heart5,
      label: 'Favourites',
    ),
    BottomNavigationItem(
      icon: Iconsax.calendar,
      activeIcon: Iconsax.calendar_1,
      label: 'Itinerary',
    ),
    BottomNavigationItem(
      icon: Iconsax.profile_circle,
      activeIcon: Iconsax.profile_circle5,
      label: 'Profile',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(), // Disable swipe
        children: _screens,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            _navItems.length,
            (index) => _buildNavItem(
              _navItems[index],
              index,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BottomNavigationItem item, int index) {
    final isActive = _currentIndex == index;
    final color = isActive ? Color(0xFF0C3C2F) : Colors.grey[600];

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: Color(0xFF0C3C2F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? item.activeIcon : item.icon,
              size: 24,
              color: color,
            ),
            SizedBox(height: 4),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
    
    // Add haptic feedback
    // Feedback.forTap(context);
  }
}

class BottomNavigationItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  BottomNavigationItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

// Custom Floating Action Button for special actions
class TravelFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isExtended;

  const TravelFloatingActionButton({
    super.key,
    required this.onPressed,
    this.isExtended = false,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Color(0xFF0C3C2F),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(Iconsax.add, size: 28),
      // For extended FAB:
      // child: isExtended
      //     ? Row(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Icon(Iconsax.add, size: 24),
      //           SizedBox(width: 8),
      //           Text('New Trip', style: TextStyle(fontWeight: FontWeight.w600)),
      //         ],
      //       )
      //     : Icon(Iconsax.add, size: 28),
    );
  }
}

// Alternative: Curved Navigation Bar (if you want a more stylish look)
class CurvedBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CurvedBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Iconsax.home, Iconsax.home_15, 'Home', 0),
            _buildNavItem(Iconsax.discover, Iconsax.discover_14, 'Explore', 1),
            SizedBox(width: 48), // Space for FAB
            _buildNavItem(Iconsax.heart, Iconsax.heart5, 'Favourites', 2),
            _buildNavItem(Iconsax.profile_circle, Iconsax.profile_circle5, 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index) {
    final isActive = currentIndex == index;
    return Expanded(
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () => onTap(index),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? activeIcon : icon,
                color: isActive ? Color(0xFF0C3C2F) : Colors.grey[600],
                size: 24,
              ),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? Color(0xFF0C3C2F) : Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Usage example with FAB
class MainNavigationWithFAB extends StatefulWidget {
  const MainNavigationWithFAB({super.key});

  @override
  State<MainNavigationWithFAB> createState() => _MainNavigationWithFABState();
}

class _MainNavigationWithFABState extends State<MainNavigationWithFAB> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    Container(), // Empty for FAB center
    FavouritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: CurvedBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
      floatingActionButton: TravelFloatingActionButton(
        onPressed: () {
          // Navigate to create new itinerary
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ItineraryScreen()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Advanced navigation with animation
class AnimatedBottomNavigation extends StatefulWidget {
  const AnimatedBottomNavigation({super.key});

  @override
  State<AnimatedBottomNavigation> createState() => _AnimatedBottomNavigationState();
}

class _AnimatedBottomNavigationState extends State<AnimatedBottomNavigation> {
  int _currentIndex = 0;
  double _position = 0.0;

  final List<Widget> _screens = [
    HomeScreen(),
    ExploreScreen(),
    FavouritesScreen(),
    ItineraryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final itemWidth = width / 5;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeOut,
              left: _position,
              child: Container(
                width: itemWidth - 16,
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF0C3C2F).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAnimatedNavItem(Iconsax.home, Iconsax.home_15, 'Home', 0, itemWidth),
                _buildAnimatedNavItem(Iconsax.discover, Iconsax.discover_14, 'Explore', 1, itemWidth),
                _buildAnimatedNavItem(Iconsax.heart, Iconsax.heart5, 'Favourites', 2, itemWidth),
                _buildAnimatedNavItem(Iconsax.calendar, Iconsax.calendar_1, 'Plans', 3, itemWidth),
                _buildAnimatedNavItem(Iconsax.profile_circle, Iconsax.profile_circle5, 'Profile', 4, itemWidth),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedNavItem(IconData icon, IconData activeIcon, String label, int index, double itemWidth) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
          _position = index * itemWidth;
        });
      },
      child: Container(
        width: itemWidth,
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              size: 24,
              color: isActive ? Color(0xFF0C3C2F) : Colors.grey[600],
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                color: isActive ? Color(0xFF0C3C2F) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}