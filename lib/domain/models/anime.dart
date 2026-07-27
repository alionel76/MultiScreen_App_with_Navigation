class Anime {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double rating;
  final String genre;

  Anime({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.genre,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'genre': genre,
    };
  }

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      genre: json['genre'] as String,
    );
  }
}
