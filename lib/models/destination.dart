import 'package:cloud_firestore/cloud_firestore.dart';
class Destination {
  final String id;
  final String name;
  final String description;
  final String location;
  final double rating;
  final List<String> images;
  final String category;
  final GeoPoint coordinates;
  final bool isFeatured;

  Destination({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.rating,
    required this.images,
    required this.category,
    required this.coordinates,
    this.isFeatured = false,
  });

  factory Destination.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Destination(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      images: List<String>.from(data['images'] ?? []),
      category: data['category'] ?? '',
      coordinates: data['coordinates'] ?? const GeoPoint(0, 0),
      isFeatured: data['isFeatured'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'location': location,
      'rating': rating,
      'images': images,
      'category': category,
      'coordinates': coordinates,
      'isFeatured': isFeatured,
    };
  }
}