import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/common/utils.dart';
import 'package:netflix/models/detailed_model.dart';
import 'package:netflix/models/movie_recomentaion_model.dart';
import 'package:netflix/sevices/api_services.dart';

class DetailScreen extends StatefulWidget {
  final int movieId;
  const DetailScreen({super.key, required this.movieId});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  ApiServices apiServices = ApiServices();
  late Future<MovieDetailModel> movieDetailFuture;
  late Future<MovieReccomantaionModel> recomentayionFuture;
  @override
  void initState() {
    super.initState();
    fetchInetialData();
  }

  fetchInetialData() {
    movieDetailFuture = apiServices.getMovieDetails(widget.movieId);
    recomentayionFuture = apiServices.getMovierecomentaion(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: movieDetailFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final movie = snapshot.data;
            if (snapshot.hasData) {
              print("movie name is  ${movie!.title}");
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: "$imageURl${movie.backdropPath.toString()}",
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      movie.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Release :  ${movie.releaseDate.year.toString()}",
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 18),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      "Rating : ${movie.voteAverage.toStringAsFixed(1)}",
                      // .map((genre) => genre.name).join(',  '),
                      style:
                          const TextStyle(color: Colors.white54, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      movie.overview,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    FutureBuilder(
                        future: recomentayionFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final movie = snapshot.data;
                            return movie!.results.isEmpty
                                ? const SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "More like this",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      GridView.builder(
                                          itemCount: movie.results.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 15,
                                            crossAxisSpacing: 5,
                                            childAspectRatio: 1.5 / 2,
                                          ),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailScreen(
                                                                movieId: movie
                                                                    .results[
                                                                        index]
                                                                    .id)));
                                              },
                                              child: CachedNetworkImage(
                                                  imageUrl:
                                                      "$imageURl${movie.results[index].posterPath}"),
                                            );
                                          })
                                    ],
                                  );
                          }
                          return const Text("Something went wrong");
                        })
                  ],
                ),
              );
            } else {
              return const Column(children: [
                SizedBox(
                  height: 350,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "The movie is not available now",
                  ),
                ),
              ]);
            }
          },
        ),
      ),
    ));
  }
}
