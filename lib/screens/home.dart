import 'package:flutter/material.dart';
import 'package:netflix/models/now_playing_model.dart';
import 'package:netflix/models/popular_movie_model.dart';
import 'package:netflix/models/popular_series_model.dart';
import 'package:netflix/models/top_rated_model.dart';
import 'package:netflix/models/top_rated_series.dart';
import 'package:netflix/models/tv_series_model.dart';
import 'package:netflix/models/upcoming_movie.dart';
import 'package:netflix/screens/search_screen.dart';
import 'package:netflix/sevices/api_services.dart';
import 'package:netflix/widgets/main%20_slider_widget.dart';
import 'package:netflix/widgets/movie_card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<UpcomingModel> upcomingFuture;
  late Future<NowPlayingModel> nowPlayingFuture;
  late Future<TopRatedModel> topRatedFuture;
  late Future<PopularMovieModel> popularMovieFuture;
  late Future<TvSeriesModel> tvSeriesFuture;
  late Future<TopRatedSeriesModel> topRatedSeriesFuture;
  late Future<PopularTvSeriesModel> popularTvSeries;
  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    upcomingFuture = apiServices.getUpcomingMovie();
    nowPlayingFuture = apiServices.getNowPlayingMovie();
    topRatedFuture = apiServices.getTopRatedMovies();
    tvSeriesFuture = apiServices.getTvSeriesMovie();
    popularMovieFuture = apiServices.getPopularMovies();
    topRatedSeriesFuture = apiServices.getTopRatedSeries();
    popularTvSeries = apiServices.getPopularTvSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.asset(
          'assets/images/7124274_netflix_logo_icon.png',
          height: 120,
          width: 140,
        ),
        actions: [
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchMovies()));
              },
              child: const Icon(
                Icons.search,
                color: Colors.white,
              )),
          const SizedBox(
            width: 30,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: nowPlayingFuture,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SliderWidget(data: snapshot.data!);
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
              SizedBox(
                height: 220,
                child: MovieCardWidget(
                    future: nowPlayingFuture, headLineText: "Now Playing"),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 220,
                child: MovieCardWidget(
                    future: upcomingFuture, headLineText: "Upcoming Movies"),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 220,
                child: MovieCardWidget(
                    future: topRatedFuture, headLineText: "Top Rated Movies"),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 220,
                child: MovieCardWidget(
                    future: popularMovieFuture, headLineText: "Popular Movies"),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 220,
                child: MovieCardWidget(
                    future: topRatedSeriesFuture,
                    headLineText: "Top Rated Series"),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 220,
                child: MovieCardWidget(
                    future: popularTvSeries, headLineText: "Popular TV Series"),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
