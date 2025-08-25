class Place {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String location;

  Place({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'location': location,
      };
}
