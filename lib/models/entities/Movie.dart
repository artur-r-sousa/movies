import 'package:intl/intl.dart';

class Movie {

  final String name;
  final String ratings;
  final String releaseDate;
  final String posterPath;

  final DateFormat formatter = DateFormat("dd-MM-yyyy");

  Movie({this.name, this.ratings, this.releaseDate, this.posterPath});

  get movieName {
    return this.name;
  }

  get movieRatings {
    return this.ratings;
  }

  String movieRelease() {
    return (formatter.parse(this.releaseDate)).toString();
  }

  @override
  String toString() {
    return 'Movie{name: $name, ratings: $ratings}';
  }
}