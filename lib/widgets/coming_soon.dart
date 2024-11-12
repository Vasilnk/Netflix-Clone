import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/common/utils.dart';
import 'package:netflix/models/upcoming_movie.dart';
import 'package:netflix/sevices/api_services.dart';

class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  ApiServices apiServices = ApiServices();
  late Future<UpcomingModel> comingSoonFuture;

  @override
  void initState() {
    comingSoonFuture = apiServices.getUpcomingMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: comingSoonFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          return ListView.builder(
            itemCount: data.results.length,
            itemBuilder: (context, index) {
              var movie = data.results[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            const SizedBox(
                              height: 35,
                            ),
                            Text(
                              months[movie.releaseDate.month - 1],
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            ),
                            Text(
                              movie.releaseDate.day.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: "$imageURl${movie.backdropPath}",
                                width: size.width,
                                height: size.height * 0.35,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                movie.title,
                                overflow: TextOverflow.visible,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 45,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Coming on ${months[movie.releaseDate.month - 1]} ${movie.releaseDate.day}",
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                                color: Colors.white54,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Row(
                          children: [
                            Column(
                              children: [
                                Icon(Icons.notifications_outlined,
                                    size: 20, color: Colors.white),
                                SizedBox(height: 4),
                                Text("Remind Me",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)),
                              ],
                            ),
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Icon(Icons.info_outline,
                                    size: 20, color: Colors.white),
                                SizedBox(height: 4),
                                Text("Info",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(
                          width: 45,
                        ),
                        Expanded(
                          child: Text(
                            movie.overview,
                            maxLines: 4,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
