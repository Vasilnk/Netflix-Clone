import 'dart:convert';

import 'package:netflix/common/utils.dart';
import 'package:netflix/models/detailed_model.dart';
import 'package:netflix/models/movie_recomentaion_model.dart';
import 'package:netflix/models/now_playing_model.dart';
import 'package:netflix/models/popular_movie_model.dart';
import 'package:netflix/models/popular_series_model.dart';
import 'package:netflix/models/search_model.dart';
import 'package:netflix/models/top_rated_model.dart';
import 'package:netflix/models/top_rated_series.dart';
import 'package:netflix/models/top_search_model.dart';
import 'package:netflix/models/tv_series_model.dart';
import 'package:netflix/models/upcoming_movie.dart';
import 'package:http/http.dart' as http;

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;

class ApiServices {
  // Upcoming Movie

  Future<UpcomingModel> getUpcomingMovie() async {
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      // print("Success : ${responce.body}");
      print("Upcoming  sucess");

      return UpcomingModel.fromJson(jsonDecode(responce.body));
    }

    throw Exception("Failed to load upcoming movies ");
  }

  // Popular  Movies

  Future<PopularMovieModel> getPopularMovies() async {
    endPoint = "discover/movie";
    final url = "$baseUrl$endPoint$key";
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      // print("Success : ${responce.body}");
      print("Popular movie  sucess");

      return PopularMovieModel.fromJson(jsonDecode(responce.body));
    }

    throw Exception("Failed to load polpular movies ");
  }

  // Popular tv series

  Future<PopularTvSeriesModel> getPopularTvSeries() async {
    endPoint = "movie/top_rated";
    final url = "$baseUrl$endPoint$key";
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      // print("Success : ${responce.body}");
      print("Popular Series  sucess");

      return PopularTvSeriesModel.fromJson(jsonDecode(responce.body));
    }

    throw Exception("Failed to load polpular Series ");
  }

  // Top rated series

  Future<TopRatedSeriesModel> getTopRatedSeries() async {
    endPoint = "tv/top_rated";
    final url = "$baseUrl$endPoint$key";
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      // print("Success : ${responce.body}");
      print("Popular movie  sucess");

      return TopRatedSeriesModel.fromJson(jsonDecode(responce.body));
    }

    throw Exception("Failed to load polpular movies ");
  }

  // Tv series

  Future<TvSeriesModel> getTvSeriesMovie() async {
    endPoint = "tv/popular";
    final url = "$baseUrl$endPoint$key";
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      // print("Success : ${responce.body}");
      print("now playing sucess");
      return TvSeriesModel.fromJson(jsonDecode(responce.body));
    }

    throw Exception("Failed to TvSeries  movies ");
  }

  // Now playing  Movies

  Future<NowPlayingModel> getNowPlayingMovie() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      // print("Success : ${responce.body}");
      print("now playing success");
      return NowPlayingModel.fromJson(jsonDecode(responce.body));
    }

    throw Exception("Failed to load now playing movies ");
  }

  // Top rated  Movies

  Future<TopRatedModel> getTopRatedMovies() async {
    endPoint = "movie/top_rated";
    final url = "$baseUrl$endPoint$key";
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      // print("Success : ${responce.body}");
      print("top rated success");

      return TopRatedModel.fromJson(jsonDecode(responce.body));
    }

    throw Exception("Failed to load Top rated movies ");
  }

  // Top search  Movies

  Future<TopSearchModel> getTopSearches() async {
    endPoint = "movie/popular";
    final url = "$baseUrl$endPoint$key";
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      // print("Success : ${responce.body}");
      print("top search success");

      return TopSearchModel.fromJson(jsonDecode(responce.body));
    }

    throw Exception("Failed to load Top rated movies ");
  }

  //  Movie details

  Future<MovieDetailModel> getMovieDetails(movieId) async {
    print(" hi from movie detail function");

    endPoint = "movie/$movieId";
    final url = "$baseUrl$endPoint$key";
    print("url is $url");
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      // print("Success : ${responce.body}");
      print("Movie details is success");

      return MovieDetailModel.fromJson(jsonDecode(responce.body));
    } else {
      print("not success");
    }
    throw Exception("Failed to load Movie details ");
  }

  // More like this Movies

  Future<MovieReccomantaionModel> getMovierecomentaion(movieId) async {
    endPoint = "movie/$movieId/recommendations";
    final url = "$baseUrl$endPoint$key";
    final responce = await http.get(Uri.parse(url));
    if (responce.statusCode == 200) {
      return MovieReccomantaionModel.fromJson(jsonDecode(responce.body));
    }
    throw Exception("Failed to load getMovierecomentaion ");
  }

  // Search Movie

  Future<SearchModel> searchMovies(String word) async {
    endPoint = "search/tv?query=$word";
    final url = "$baseUrl$endPoint";
    print("Search  success $url");
    final responce = await http.get(Uri.parse(url), headers: {
      'Authorization':
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc"
    });
    if (responce.statusCode == 200) {
      // print("Success : ${responce.body}");

      return SearchModel.fromJson(jsonDecode(responce.body));
    }

    throw Exception("Failed to load Search Movies ");
  }
}
