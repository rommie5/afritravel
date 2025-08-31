import 'package:flutter/material.dart';

class Category {
  final int id;
  final String name;
  final String icon; // store icon name as string, e.g., 'landscape'

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
      };

  // Map string to IconData
  IconData get iconData {
    switch (icon) {
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
        return Icons.category;
    }
  }
}
