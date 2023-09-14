import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_info/model/cast_crew.dart';

import 'package:movie_info/model/movieDetail.dart';
import 'package:movie_info/model/person.dart';
import 'package:movie_info/model/tvDetail.dart';

class APIService {
  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'c37e879922024e7b447766addfb964a2';

  Future getTrendingMovie() async {
    final url = '$baseUrl/trending/movie/day?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(aaa);
      return data['results'];
    } else {
      return print('aaaaaaa');
    }
  }

  Future getNowPlayingMovie() async {
    final url = '$baseUrl/movie/now_playing?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(aaa);
      return data['results'];
    } else {
      return print('aaaaaaa');
    }
  }

  Future getUpcomingMovie() async {
    final url = '$baseUrl/movie/upcoming?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));

    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return data['results'];
    } else {
      return print('aaaaaaa');
    }
  }

  Future getPopularMovie() async {
    final url = '$baseUrl/movie/popular?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return data['results'];
    } else {
      return print('network error');
    }
  }

  Future getTopRatedMovies() async {
    final url = '$baseUrl/movie/top_rated?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(data['results'].toString());
      return data['results'];
    } else {
      return print('network error');
    }
  }

  Future<MovieDeatil> getMovieDetail(int movieId) async {
    final url = '$baseUrl/movie/${movieId}?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    MovieDeatil movieDeatil = MovieDeatil.fromJson(data);

    if (response.statusCode == 200) {
      return movieDeatil;
    } else {
      return movieDeatil; //print('network error');
      // return Movie.fromJson(data['resluts']);
    }
  }

  Future<CastCrew> getMovieCast(int movieId) async {
    final url = '$baseUrl/movie/${movieId}/credits?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    CastCrew castCrew = CastCrew.fromJson(data);

    if (response.statusCode == 200) {
      return castCrew;
    } else {
      Exception(); // give status code 404 error sometime solve?      // return Movie.fromJson(data['resluts']);
    }
    return castCrew;
  }

  Future<Person> getPerson(int personID) async {
    final url = '$baseUrl/person/${personID}?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    Person person = Person.fromJson(data);

    if (response.statusCode == 200) {
      return person;
    } else {
      return person; //print('network error');
      // return Movie.fromJson(data['resluts']);
    }
  }

  Future personMovies(int personID) async {
    final url = '$baseUrl/person/${personID}/movie_credits?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    //  Person person = Person.fromJson(data);

    if (response.statusCode == 200) {
      print(data);
      return data;
    } else {
      return data; //print('network error');
      // return Movie.fromJson(data['resluts']);
    }
  }

  Future searchMovie(String search) async {
    final url = '$baseUrl/search/movie?query=${search}&api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return data['results'];
    } else {
      return print('network error');
    }
  }

  Future searchPerson(String search) async {
    final url = '$baseUrl/search/person?query=${search}&api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(data['results'].toString());
      return data['results'];
    } else {
      return print('network error');
    }
  }

  Future searchTV(String search) async {
    final url = '$baseUrl/search/tv?query=${search}&api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return data['results'];
    } else {
      return print('network error');
    }
  }

  //  **********************************************8 TV shows  ****************************************************************

  Future getTrendingTV() async {
    final url = '$baseUrl/trending/tv/day?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(aaa);
      return data['results'];
    } else {
      return data['results'];
    }
  }

  Future getTodayTV() async {
    final url = '$baseUrl/tv/airing_today?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(aaa);
      return data['results'];
    } else {
      return data['results'];
    }
  }

  Future getOnTV() async {
    final url = '$baseUrl/tv/on_the_air?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(aaa);
      return data['results'];
    } else {
      return data['results'];
    }
  }

  Future getPopularTV() async {
    final url = '$baseUrl/tv/popular?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(aaa);
      return data['results'];
    } else {
      return data['results'];
    }
  }

  Future getTopRatedTV() async {
    final url = '$baseUrl/tv/top_rated?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(aaa);
      return data['results'];
    } else {
      return data['results'];
    }
  }

  Future getNetflixTV() async {
    final url =
        '$baseUrl/discover/tv?sort_by=popularity.desc&timezone=day&watch_region=IN&with_networks=213&api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(aaa);
      return data['results'];
    } else {
      return data['results'];
    }
  }

  Future getDisneyTV() async {
    final url =
        '$baseUrl/discover/tv?sort_by=popularity.desc&timezone=day&watch_region=IN&with_networks=2739&api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(aaa);
      return data['results'];
    } else {
      return data['results'];
    }
  }

  Future getAmazonTV() async {
    final url =
        '$baseUrl/discover/tv?sort_by=popularity.desc&timezone=day&watch_region=IN&with_networks=1024&api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(aaa);
      return data['results'];
    } else {
      return data['results'];
    }
  }

  Future<TVdetails> getTVdetail(int TvId) async {
    final url = '$baseUrl/tv/${TvId}?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    TVdetails tVdetails = TVdetails.fromJson(data);

    if (response.statusCode == 200) {
      return tVdetails;
    } else {
      return tVdetails; //print('network error');
      // return Movie.fromJson(data['resluts']);
    }
  }

  Future getTVCast(int TvId) async {
    final url = '$baseUrl/tv/${TvId}/credits?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return data['cast'];
    } else {
      Exception(); // give status code 404 error sometime solve?      // return Movie.fromJson(data['resluts']);
    }
    return data['cast'];
  }

  Future personTV(int personID) async {
    final url = '$baseUrl/person/${personID}/tv_credits?api_key=$apiKey';
    final response = await http.get(Uri.parse(url));
    final data = jsonDecode(response.body.toString());

    //  Person person = Person.fromJson(data);

    if (response.statusCode == 200) {
      //  print(data);
      return data;
    } else {
      return data; //print('network error');
      // return Movie.fromJson(data['resluts']);
    }
  }
}
