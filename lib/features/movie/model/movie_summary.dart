class MovieSummary{
  final String imdbID;
  final String title;
  final String year;
  final String poster;


  factory MovieSummary.fromJson(Map<String, dynamic> json) => MovieSummary(
        imdbID: json['imdbID'] ?? '',
        title: json['Title'] ?? '',
        year: json['Year'] ?? '',
        poster: json['Poster'] ?? '',
      );

  MovieSummary({
    required this.imdbID,
    required this.title,
    required this.year,
    required this.poster,
  });

}
