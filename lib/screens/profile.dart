import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> _userData = {
    'name': 'Sarah Johnson',
    'email': 'sarah.j@example.com',
    'phone': '+256 772 123456',
    'avatar': 'assets/avatar.jpg',
    'memberSince': 'March 2024',
    'travelerType': 'Adventure Seeker',
    'level': 'Explorer',
    'points': 1250,
  };

  final List<Map<String, dynamic>> _travelStats = [
    {'label': 'Trips', 'value': '7', 'icon': Iconsax.airplane},
    {'label': 'Countries', 'value': '3', 'icon': Iconsax.map_1},
    {'label': 'Cities', 'value': '12', 'icon': Iconsax.buildings},
    {'label': 'Photos', 'value': '248', 'icon': Iconsax.camera},
  ];

  final List<Map<String, dynamic>> _settingsSections = [
    {
      'title': 'Account',
      'items': [
        {
          'icon': Iconsax.profile_circle,
          'label': 'Personal Information',
          'trailing': Iconsax.arrow_right_3,
        },
        {
          'icon': Iconsax.shield_tick,
          'label': 'Privacy & Security',
          'trailing': Iconsax.arrow_right_3,
        },
        {
          'icon': Iconsax.card,
          'label': 'Payment Methods',
          'trailing': Iconsax.arrow_right_3,
        },
        {
          'icon': Iconsax.notification,
          'label': 'Notifications',
          'trailing': Iconsax.arrow_right_3,
        },
      ],
    },
    {
      'title': 'Preferences',
      'items': [
        {'icon': Iconsax.global, 'label': 'Language', 'trailing': 'English'},
        {
          'icon': Iconsax.moon,
          'label': 'Dark Mode',
          'trailing': Switch(value: true, onChanged: (value) {}),
        },
        {
          'icon': Iconsax.map,
          'label': 'Offline Maps',
          'trailing': Iconsax.arrow_right_3,
        },
        {
          'icon': Iconsax.filter,
          'label': 'Content Preferences',
          'trailing': Iconsax.arrow_right_3,
        },
      ],
    },
    {
      'title': 'Support',
      'items': [
        {
          'icon': Iconsax.headphone,
          'label': 'Help Center',
          'trailing': Iconsax.arrow_right_3,
        },
        {
          'icon': Iconsax.info_circle,
          'label': 'About App',
          'trailing': Iconsax.arrow_right_3,
        },
        {
          'icon': Iconsax.document,
          'label': 'Terms of Service',
          'trailing': Iconsax.arrow_right_3,
        },
        {
          'icon': Iconsax.security_card,
          'label': 'Privacy Policy',
          'trailing': Iconsax.arrow_right_3,
        },
      ],
    },
  ];

  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xFF0C3C2F),
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Profile',
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
                icon: Icon(Iconsax.setting_2, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // User Profile Card
                  _buildProfileCard(),
                  SizedBox(height: 24),

                  // Travel Statistics
                  _buildTravelStats(),
                  SizedBox(height: 24),

                  // Settings Sections
                  _buildSettingsSections(),
                  SizedBox(height: 24),

                  // Logout Button
                  _buildLogoutButton(),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Avatar and Basic Info
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF0C3C2F).withOpacity(0.1),
                    border: Border.all(
                      color: Color(0xFF0C3C2F).withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Iconsax.profile_circle,
                    size: 40,
                    color: Color(0xFF0C3C2F),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userData['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _userData['email'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _userData['phone'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Iconsax.edit_2, color: Color(0xFF0C3C2F)),
                  onPressed: () => _editProfile(),
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),

            // Additional User Info
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem('Member Since', _userData['memberSince']),
                _buildInfoItem('Traveler Type', _userData['travelerType']),
                _buildInfoItem('Level', _userData['level']),
              ],
            ),
            SizedBox(height: 16),

            // Points and Progress
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF0C3C2F).withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Iconsax.award, color: Color(0xFF0C3C2F), size: 20),
                  SizedBox(width: 8),
                  Text(
                    '${_userData['points']} points',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0C3C2F),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Next level: 2000 points',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF0C3C2F),
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildTravelStats() {
    return Container(
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Travel Statistics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 16),
            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: _travelStats.length,
              itemBuilder: (context, index) {
                final stat = _travelStats[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF0C3C2F).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(stat['icon'], size: 24, color: Color(0xFF0C3C2F)),
                      SizedBox(height: 8),
                      Text(
                        stat['value'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0C3C2F),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        stat['label'],
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSections() {
    return Column(
      children: _settingsSections.map((section) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  section['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
              ),
              ...section['items'].map<Widget>((item) {
                return ListTile(
                  leading: Icon(
                    item['icon'],
                    color: Color(0xFF0C3C2F),
                    size: 22,
                  ),
                  title: Text(item['label']),
                  trailing: item['trailing'] is IconData
                      ? Icon(item['trailing'], size: 18, color: Colors.grey)
                      : item['trailing'] is String
                      ? Text(
                          item['trailing'],
                          style: TextStyle(color: Colors.grey[600]),
                        )
                      : item['trailing'] is Switch
                      ? Switch(
                          value: _isDarkMode,
                          onChanged: (value) {
                            setState(() {
                              _isDarkMode = value;
                            });
                          },
                          activeThumbColor: Color(0xFF0C3C2F),
                        )
                      : null,
                  onTap: () => _handleSettingTap(item['label']),
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  visualDensity: VisualDensity(vertical: -2),
                );
              }).toList(),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => _showLogoutDialog(),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.red,
          side: BorderSide(color: Colors.red),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Iconsax.logout, size: 20),
            SizedBox(width: 8),
            Text('Log Out', style: TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  void _editProfile() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Edit Profile',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Iconsax.profile_circle),
                ),
                controller: TextEditingController(text: _userData['name']),
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Iconsax.sms),
                ),
                controller: TextEditingController(text: _userData['email']),
              ),
              SizedBox(height: 12),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Iconsax.call),
                ),
                controller: TextEditingController(text: _userData['phone']),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Profile updated successfully'),
                        backgroundColor: Color(0xFF0C3C2F),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0C3C2F),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('Save Changes'),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _handleSettingTap(String setting) {
    switch (setting) {
      case 'Personal Information':
        _editProfile();
        break;
      case 'Privacy & Security':
        // Navigate to privacy settings
        break;
      case 'Payment Methods':
        // Navigate to payment methods
        break;
      case 'Notifications':
        // Navigate to notification settings
        break;
      case 'Language':
        _showLanguageDialog();
        break;
      case 'Offline Maps':
        // Navigate to offline maps
        break;
      case 'Content Preferences':
        // Navigate to content preferences
        break;
      case 'Help Center':
        // Navigate to help center
        break;
      case 'About App':
        _showAboutDialog();
        break;
      case 'Terms of Service':
        // Navigate to terms
        break;
      case 'Privacy Policy':
        // Navigate to privacy policy
        break;
    }
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('English'),
                trailing: Icon(Iconsax.tick_circle, color: Color(0xFF0C3C2F)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text('Luganda'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                title: Text('Swahili'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('About Uganda Explore'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                SizedBox(height: 12),
                Text(
                  'Uganda Explore is your ultimate travel companion for discovering the beautiful Pearl of Africa. Plan your trips, explore destinations, and create unforgettable memories.',
                ),
                SizedBox(height: 12),
                Text(
                  '© 2024 Uganda Explore. All rights reserved.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Log Out'),
          content: Text('Are you sure you want to log out of your account?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Perform logout logic
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Logged out successfully'),
                    backgroundColor: Color(0xFF0C3C2F),
                  ),
                );
              },
              child: Text('Log Out', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
