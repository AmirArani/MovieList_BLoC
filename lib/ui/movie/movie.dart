import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/data/repository/movie_detail_repository.dart';
import 'package:movie_list/models/genres_entity.dart';
import 'package:movie_list/models/movie_details_entity.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../theme_data.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({Key? key, required this.movie, required this.category})
      : super(key: key);

  final MovieEntity movie;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 440,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: FutureBuilder(
                      future: movieDetailRepository.getMovieBackdrop(id: movie.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<MovieBackdropEntity> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return Image(
                            image: CachedNetworkImageProvider(
                                'https://image.tmdb.org/t/p/w400' +
                                    snapshot.data!.backdropPath),
                          );
                        } else {
                          return Shimmer(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width * 0.57,
                              color: LightThemeColors.background,
                            ),
                            gradient: LinearGradient(
                              colors: [
                                LightThemeColors.tertiary.withOpacity(0.3),
                                LightThemeColors.secondary.withOpacity(0.2)
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: 170,
                    left: 20,
                    child: Hero(
                      transitionOnUserGestures: true,
                      tag: movie.id.toString() + category,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8,
                              color: LightThemeColors.gray.withOpacity(0.5),
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w185' + movie.posterPath,
                            width: 172,
                            height: 257,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 240,
                    left: 205,
                    width: 185,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        FutureBuilder(
                          future: movieDetailRepository.getMovieDetail(id: movie.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<MovieDetailEntity> snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data!.tagLine),
                                  const SizedBox(height: 12),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color:
                                              LightThemeColors.gray.withOpacity(0.7),
                                        ),
                                        child: Text(
                                          snapshot.data!.originalLanguage,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      const Icon(CupertinoIcons.star,
                                          color: Color(0xffEDC700), size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        snapshot.data!.vote.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(
                                                color: const Color(0xffEDC700),
                                                fontWeight: FontWeight.normal),
                                      ),
                                      const SizedBox(width: 15),
                                      const Icon(CupertinoIcons.clock,
                                          size: 18, color: LightThemeColors.primary),
                                      const SizedBox(width: 4),
                                      Text(snapshot.data!.runtime.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2!
                                              .copyWith(
                                                  fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Wrap(
                                    clipBehavior: Clip.hardEdge,
                                    spacing: 5,
                                    runSpacing: 5,
                                    children: [
                                      for (var genre in snapshot.data!.genres)
                                        Container(
                                          padding:
                                              const EdgeInsets.fromLTRB(8, 5, 8, 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            color: LightThemeColors.tertiary
                                                .withOpacity(0.8),
                                          ),
                                          child: Text(
                                              GenreEntity.fromJson(genre).name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w300)),
                                        )
                                    ],
                                  )
                                ],
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _BottomTabBar(
              movie: movie,
            )
          ],
        ),
      ),
    );
  }
}

class _BottomTabBar extends StatelessWidget {
  const _BottomTabBar({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieEntity movie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 480,
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: TabBar(
            physics: const BouncingScrollPhysics(),
            labelColor: LightThemeColors.primary,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w300),
            unselectedLabelColor: LightThemeColors.primary.withOpacity(0.4),
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            indicatorWeight: 3,
            labelPadding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
            indicator: DotIndicator(
              distanceFromCenter: 15,
              color: LightThemeColors.primary,
            ),
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Cast & Crew'),
              Tab(text: 'Reviews'),
              Tab(text: 'Similar Movies'),
            ],
          ),
          body: TabBarView(
            children: [
              _OverviewTab(movie: movie),
              Column(
                children: [Text('Cast')],
              ),
              Icon(CupertinoIcons.settings),
              Icon(CupertinoIcons.settings),
            ],
          ),
        ),
      ),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  _OverviewTab({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieEntity movie;
  final PageController _controller = PageController(viewportFraction: 0.85);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 15, 32, 5),
            child: Text(movie.overview),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 10, 32, 30),
            child: Text('Release Date: ' + movie.releaseDate),
          ),
          FutureBuilder(
            future: movieDetailRepository.getImages(id: movie.id),
            builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return _BackdropSlider(
                  controller: _controller,
                  imagesPath: snapshot.data!,
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}

class _BackdropSlider extends StatelessWidget {
  const _BackdropSlider({
    Key? key,
    required PageController controller,
    required this.imagesPath,
  })  : _controller = controller,
        super(key: key);

  final PageController _controller;
  final List<String> imagesPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 185,
          child: PageView.builder(
            pageSnapping: true,
            controller: _controller,
            itemCount: imagesPath.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w400' + imagesPath[index],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: SmoothPageIndicator(
            count: imagesPath.length,
            controller: _controller,
            axisDirection: Axis.horizontal,
            effect: SwapEffect(
              spacing: 4,
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: LightThemeColors.primary,
              dotColor: LightThemeColors.primary.withOpacity(0.1),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
