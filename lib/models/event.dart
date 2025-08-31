class Event {
  final int id;
  final String name;
  final String location;
  final String date;
  final String imageUrl;

  Event({
    required this.id,
    required this.name,
    required this.location,
    required this.date,
    required this.imageUrl,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      date: json['date'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'date': date,
        'imageUrl': imageUrl,
      };
}
