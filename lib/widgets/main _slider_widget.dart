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
      height: 200,
      child: CarouselSlider.builder(
        itemCount: data.results.length,
        itemBuilder: (context, int index, int realIndex) {
          var url = data.results[index].backdropPath.toString();
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(movieId: data.results[index].id),
                    ),
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: "$imageURl$url",
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    data.results[index].title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        },
        options: CarouselOptions(
          height: 200,
          aspectRatio: 16 / 9,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          initialPage: 0,
        ),
      ),
    );
  }
}
