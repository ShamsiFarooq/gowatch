class MovieDetails{

   final String id;
  final String title;
  final String year;
  final String genre;
  final String director;
  final String actors;
  String? poster;

factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
        id: json['imdbID'] ?? '',
        title: json['Title'] ?? '',
        year: json['Year'] ?? '',
        genre: json['Genre'] ?? '',
        director: json['Director'] ?? '',
        actors: json['Actors'] ?? '',
        poster: json['Poster'] ?? '',
      );

  MovieDetails({
    required this.id,
    required this.title,
    required this.year,
    required this.genre,
    required this.director,
    required this.actors,
    this.poster,
  });
}