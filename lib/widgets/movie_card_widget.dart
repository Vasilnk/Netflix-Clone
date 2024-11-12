import 'package:flutter/material.dart';
import 'package:netflix/common/utils.dart';
import 'package:netflix/screens/detail_screen.dart';

class MovieCardWidget extends StatelessWidget {
  final Future<dynamic> future;

  final String headLineText;
  const MovieCardWidget(
      {super.key, required this.future, required this.headLineText});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.results;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  $headLineText",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 17,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailScreen(movieId: data[index].id)));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  "$imageURl${data[index].posterPath}")),
                        ),
                      );
                    },
                    itemCount: data!.length,
                  ),
                )
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
