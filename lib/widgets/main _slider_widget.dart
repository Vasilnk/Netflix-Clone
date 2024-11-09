import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:netflix/common/utils.dart';
import 'package:netflix/models/now_playing_model.dart';
import 'package:netflix/screens/detail_screen.dart';

class SliderWidget extends StatelessWidget {
  final NowPlayingModel data;
  const SliderWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: (size.height * 0.40 < 300) ? 300 : size.height * 0.40,
      child: CarouselSlider.builder(
          itemCount: data.results.length,
          itemBuilder: (context, int index, int realIndex) {
            var url = data.results[index].backdropPath.toString();
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(movieId: data.results[index].id)));
                },
                child: Column(
                  children: [
                    CachedNetworkImage(imageUrl: "$imageURl$url"),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      data.results[index].title,
                      style: const TextStyle(fontSize: 10),
                    )
                  ],
                ));
          },
          options: CarouselOptions(
              height: (size.height * 0.30 < 300) ? 300 : size.height * 0.30,
              aspectRatio: 16 / 9,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(
                seconds: 3,
              ),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              initialPage: 0)),
    );
  }
}
