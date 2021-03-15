import 'dart:convert';
import 'package:http/http.dart' as http;


import 'models/entities/Movie.dart';

class ApiControl {

  List moviesList;

  Future<List<Movie>> fetchMovies(String movieName) async {
    final response = await http.get(
        "https://api.themoviedb.org/3/search/movie?api_key=4daf50c5bd87a62ed672d8a59c851a26&query=" +
            movieName);
    if (response.statusCode == 200) {
      print('api call ok');
      return listFromJson(jsonDecode(response.body));
    } else {
      print('failed');
      throw Exception('failed to load');
    }
  }

  static List list;

  List<Movie> listFromJson(Map<String, dynamic> json) {

    list = json['results'];
    return List.generate(list.length, (i) {
      return Movie(
          name: json['results'][i]['original_title'],
          ratings: json['results'][i]['vote_average'].toString(),
          releaseDate: json['results'][i]['release_date'],
          posterPath: json['results'][i]['poster_path'].toString()
      );
    });
  }

}
