import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 16),
            Text('John Doe', style: TextStyle(fontSize: 22)),
            SizedBox(height: 8),
            Text('john.doe@example.com'),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () {}, child: Text('Logout')),
          ],
        ),
      ),
    );
  }

}

