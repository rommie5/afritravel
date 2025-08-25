class Tour {
  final int id;
  final String name;
  final String location;
  final double rating;
  final String imageUrl;

  Tour({
    required this.id,
    required this.name,
    required this.location,
    required this.rating,
    required this.imageUrl,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    return Tour(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'rating': rating,
        'imageUrl': imageUrl,
      };
}
