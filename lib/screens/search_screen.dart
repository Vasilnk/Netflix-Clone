import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix/common/utils.dart';
import 'package:netflix/models/search_model.dart';
import 'package:netflix/models/top_search_model.dart';
import 'package:netflix/screens/detail_screen.dart';
import 'package:netflix/sevices/api_services.dart';

class SearchMovies extends StatefulWidget {
  const SearchMovies({super.key});
  @override
  State<SearchMovies> createState() => _SearchMoviesState();
}

class _SearchMoviesState extends State<SearchMovies> {
  TextEditingController searchEditingController = TextEditingController();
  ApiServices apiServices = ApiServices();
  late Future<TopSearchModel> topSearchFuture;
  SearchModel? searchModel;
  Future<void> search(String query) async {
    if (query.isEmpty) return;

    final results = await apiServices.searchMovies(query);
    setState(() {
      searchModel = results;
    });
  }

  @override
  void initState() {
    super.initState();
    topSearchFuture = apiServices.getTopSearches();
  }

  @override
  void dispose() {
    searchEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  onChanged: (value) async {
                    await Future.delayed(const Duration(milliseconds: 500));
                    search(value);
                  },
                  controller: searchEditingController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    filled: true,
                    fillColor: Colors.grey[850],
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white70,
                    ),
                    hintText: "Search",
                    hintStyle: const TextStyle(color: Colors.white54),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        size: 20,
                        color: Colors.white24,
                      ),
                      onPressed: () {
                        searchEditingController.clear();
                        setState(() {
                          searchModel = null;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  autofocus: false,
                ),
                const SizedBox(
                  height: 16,
                ),
                searchEditingController.text.isEmpty
                    ? FutureBuilder(
                        future: topSearchFuture,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data?.results;
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Top Searches",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DetailScreen(
                                                              movieId:
                                                                  data[index]
                                                                      .id,
                                                            )));
                                              },
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 150,
                                                    child: Image.network(
                                                        "$imageURl${data[index].posterPath}"),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    child: SizedBox(
                                                      child: Text(
                                                        data[index].title,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: data!.length,
                                  )
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        })
                    : searchModel == null
                        ? const SizedBox.shrink()
                        : GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: searchModel!.results.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 5,
                              childAspectRatio: 1.2 / 2,
                            ),
                            itemBuilder: (context, index) {
                              final result = searchModel!.results[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailScreen(
                                              movieId: result.id)));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    searchModel!.results[index].backdropPath ==
                                            null
                                        ? Image.asset(
                                            'assets/images/BrandAssets_Logos_02-NSymbol.jpg',
                                            fit: BoxFit.cover,
                                            height: 170,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl:
                                                "$imageURl${result.backdropPath}",
                                            height: 170,

                                            fit: BoxFit.cover,
                                            // ),
                                          ),
                                    Flexible(
                                      child: Text(
                                        result.name,
                                        style: const TextStyle(
                                            color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
