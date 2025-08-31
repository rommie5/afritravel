import 'package:afri_travel/screens/explore.dart';
import 'package:afri_travel/screens/favourites.dart';
import 'package:afri_travel/screens/home1.dart';
import 'package:afri_travel/screens/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'screens/auth/login.dart';
import 'screens/auth/signup.dart';
import 'screens/itinerary.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ToursApp());
}

class ToursApp extends StatelessWidget {
  const ToursApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uganda Explore',
      theme: ThemeData(
        primaryColor: const Color(0xFF0C3C2F),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(0xFF0C3C2F, {
            50: Color(0xFFE8F5E9),
            100: Color(0xFFC8E6C9),
            200: Color(0xFFA5D6A7),
            300: Color(0xFF81C784),
            400: Color(0xFF66BB6A),
            500: Color(0xFF0C3C2F),
            600: Color(0xFF1A5E48),
            700: Color(0xFF0C3C2F),
            800: Color(0xFF2E7D32),
            900: Color(0xFF1B5E20),
          }),
        ),
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0C3C2F),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/main': (context) => const MainNavigation(), // Add this route
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

/// This widget decides which screen to show based on auth state
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If snapshot has data, user is logged in
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return const LoginScreen(); // Not logged in
          } else {
            return const MainNavigation(); // Use MainNavigation instead of HomeScreen
          }
        }

        // Loading state
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

// Main Navigation Widget (Add this to your main.dart or create separate file)
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  // List of screens for navigation - using your actual screen classes
  final List<Widget> _screens = [
    HomeScreen(), // Your home1.dart screen
    ExploreScreen(), // Your explore.dart screen
    FavouritesScreen(), // Your favourites.dart screen
    ItineraryScreen(), // Your itinerary.dart screen
    ProfileScreen(), // Your profile.dart screen
  ];

  // Bottom navigation items
  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home, 'activeIcon': Icons.home_filled, 'label': 'Home'},
    {
      'icon': Icons.explore,
      'activeIcon': Icons.explore_outlined,
      'label': 'Explore',
    },
    {
      'icon': Icons.favorite_border,
      'activeIcon': Icons.favorite,
      'label': 'Favourites',
    },
    {
      'icon': Icons.calendar_today,
      'activeIcon': Icons.calendar_month,
      'label': 'Itinerary',
    },
    {
      'icon': Icons.person_outline,
      'activeIcon': Icons.person,
      'label': 'Profile',
    },
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
        physics: const NeverScrollableScrollPhysics(), // Disable swipe
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
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
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
            (index) => _buildNavItem(_navItems[index], index),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(Map<String, dynamic> item, int index) {
    final isActive = _currentIndex == index;
    final color = isActive ? const Color(0xFF0C3C2F) : Colors.grey[600];

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isActive
            ? BoxDecoration(
                color: const Color(0xFF0C3C2F).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? item['activeIcon'] : item['icon'],
              size: 24,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              item['label'],
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
  }
}
