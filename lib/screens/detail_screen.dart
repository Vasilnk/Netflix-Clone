import 'package:flutter/material.dart';
import 'package:netflix/common/utils.dart';
import 'package:netflix/models/detailed_model.dart';
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
  @override
  void initState() {
    super.initState();
    fetchInetialData();
  }

  fetchInetialData() {
    movieDetailFuture = apiServices.getMovieDetails(widget.movieId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("movie id is ${widget.movieId}");
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: movieDetailFuture,
          builder: (context, snapshot) {
            final movie = snapshot.data;
            if (snapshot.hasData) {
              print("movie name is  ${movie!.title}");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "$imageURl${movie.posterPath}"))),
                      )
                    ],
                  ),
                  Text(
                    movie.title,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
      ),
    ));
  }
}
