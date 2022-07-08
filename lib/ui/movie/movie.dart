import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/data/repository/movie_detail_repository.dart';
import 'package:movie_list/models/credit_entity.dart';
import 'package:movie_list/models/genres_entity.dart';
import 'package:movie_list/models/movie_details_entity.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:movie_list/models/review_entity.dart';
import 'package:movie_list/ui/common_widgets.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../models/common.dart';
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
                  _TopBackDrop(movieId: movie.id),
                  _MainPoster(
                    category: category,
                    posterPath: movie.posterPath,
                    id: movie.id,
                  ),
                  _TitleAndInfo(title: movie.title, id: movie.id),
                ],
              ),
            ),
            _BottomTabBar(movie: movie)
          ],
        ),
      ),
    );
  }
}

class _TopBackDrop extends StatelessWidget {
  const _TopBackDrop({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: FutureBuilder(
        future: movieDetailRepository.getMovieBackdrop(id: movieId),
        builder: (BuildContext context, AsyncSnapshot<BackdropEntity> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return CachedNetworkImage(
              imageUrl:
                  'https://image.tmdb.org/t/p/w400${snapshot.data!.backdropPath}',
              fadeInCurve: Curves.easeIn,
            );
          } else {
            return Shimmer(
              gradient: LinearGradient(
                colors: [
                  LightThemeColors.tertiary.withOpacity(0.3),
                  LightThemeColors.secondary.withOpacity(0.2)
                ],
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.57,
                color: LightThemeColors.background,
              ),
            );
          }
        },
      ),
    );
  }
}

class _MainPoster extends StatelessWidget {
  const _MainPoster({
    Key? key,
    required this.category,
    required this.id,
    required this.posterPath,
  }) : super(key: key);

  final int id;
  final String posterPath;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 170,
      left: 20,
      child: Hero(
        transitionOnUserGestures: true,
        tag: id.toString() + category,
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
            child: CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w185$posterPath',
              width: 172,
              height: 257,
              fit: BoxFit.cover,
              fadeInCurve: Curves.easeIn,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}

class _TitleAndInfo extends StatelessWidget {
  const _TitleAndInfo({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);

  final String title;
  final int id;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 240,
      left: 205,
      width: 185,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          FutureBuilder(
            future: movieDetailRepository.getMovieDetail(id: id),
            builder:
                (BuildContext context, AsyncSnapshot<MovieDetailEntity> snapshot) {
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
                            color: LightThemeColors.gray.withOpacity(0.7),
                          ),
                          child: Text(
                            snapshot.data!.originalLanguage,
                            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                color: Colors.white, fontWeight: FontWeight.normal),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Icon(CupertinoIcons.star,
                            color: Color(0xffEDC700), size: 18),
                        const SizedBox(width: 4),
                        Text(
                          snapshot.data!.vote.toString(),
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
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
                                .copyWith(fontWeight: FontWeight.normal)),
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
                            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: LightThemeColors.tertiary.withOpacity(0.8),
                            ),
                            child: Text(GenreEntity.fromJson(genre).name,
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
                return Shimmer(
                  gradient: LinearGradient(
                    colors: [
                      LightThemeColors.tertiary.withOpacity(0.2),
                      LightThemeColors.secondary.withOpacity(0.1)
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: LightThemeColors.background,
                        ),
                        height: 25,
                        width: 128,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: LightThemeColors.background,
                            ),
                            height: 25,
                            width: 50,
                          ),
                          const SizedBox(width: 1),
                          Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: LightThemeColors.background,
                            ),
                            height: 25,
                            width: 50,
                          ),
                          const SizedBox(width: 1),
                          Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: LightThemeColors.background,
                            ),
                            height: 25,
                            width: 50,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
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
      height: 530,
      child: Expanded(
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
                _TabOverview(movie: movie),
                _TabCastAndCrew(movieId: movie.id),
                _TabsReviews(movieId: movie.id),
                _TabSimilarMovies(movieId: movie.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TabOverview extends StatelessWidget {
  _TabOverview({
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
            child: Text('Release Date: ${movie.releaseDate}'),
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
                return Center(
                  child: Shimmer(
                    gradient: LinearGradient(
                      colors: [
                        LightThemeColors.tertiary.withOpacity(0.2),
                        LightThemeColors.secondary.withOpacity(0.1)
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: LightThemeColors.background,
                      ),
                      height: 190,
                      width: 320,
                    ),
                  ),
                );
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
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/w400${imagesPath[index]}',
                  fadeInCurve: Curves.easeIn,
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

class _TabCastAndCrew extends StatelessWidget {
  const _TabCastAndCrew({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 32, 0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
          future: movieDetailRepository.getCastAndCrew(id: movieId),
          builder: (BuildContext context, AsyncSnapshot<CreditEntity> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              var cast = snapshot.data!.cast;
              var crew = snapshot.data!.crew;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    'Cast',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: cast.length,
                    itemBuilder: (context, index) {
                      return VerticalPersonListItem(
                        id: cast[index].id,
                        name: cast[index].name,
                        profilePath: cast[index].profilePath,
                        subtitle: cast[index].character,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Crew',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 10),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: crew.length,
                    itemBuilder: (context, index) {
                      return VerticalPersonListItem(
                        id: crew[index].id,
                        name: crew[index].name,
                        profilePath: crew[index].profilePath,
                        subtitle: crew[index].job,
                      );
                    },
                  ),
                ],
              );
            } else {
              return const _DefaultVerticalListShimmer();
            }
          },
        ),
      ),
    );
  }
}

class _TabsReviews extends StatelessWidget {
  const _TabsReviews({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 32, 0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
          future: movieDetailRepository.getReviews(id: movieId),
          builder:
              (BuildContext context, AsyncSnapshot<List<ReviewEntity>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return _ReviewItem(
                    avatar: snapshot.data![index].avatar,
                    author: snapshot.data![index].author,
                    content: snapshot.data![index].content,
                    url: snapshot.data![index].url,
                  );
                },
              );
            } else {
              return const _DefaultVerticalListShimmer();
            }
          },
        ),
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem({
    Key? key,
    required this.avatar,
    required this.author,
    required this.content,
    required this.url,
  }) : super(key: key);

  final String avatar;
  final String author;
  final String content;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CachedNetworkImage(
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: avatar.contains('gravatar')
                    ? avatar.substring(1)
                    : 'https://image.tmdb.org/t/p/w185$avatar',
                fadeInCurve: Curves.easeIn,
                width: 48,
                height: 48,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              author,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            const Expanded(child: SizedBox()),
            TextButton(
                onPressed: () {
                  // TODO: use url here
                },
                child: const Text(
                  'Read full review',
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                ))
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

class _TabSimilarMovies extends StatelessWidget {
  const _TabSimilarMovies({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 32, 0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
          future: movieDetailRepository.getSimilar(id: movieId),
          builder:
              (BuildContext context, AsyncSnapshot<List<MovieEntity>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return VerticalMovieListItem(
                    movieEntity: snapshot.data![index],
                    category: 'similar',
                  );
                },
              );
            } else {
              return const _DefaultVerticalListShimmer();
            }
          },
        ),
      ),
    );
  }
}

class _DefaultVerticalListShimmer extends StatelessWidget {
  const _DefaultVerticalListShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          LightThemeColors.tertiary.withOpacity(0.2),
          LightThemeColors.secondary.withOpacity(0.1)
        ],
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: LightThemeColors.background,
              ),
              height: 150,
              width: 350,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: LightThemeColors.background,
              ),
              height: 150,
              width: 350,
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: LightThemeColors.background,
              ),
              height: 150,
              width: 350,
            ),
          ],
        ),
      ),
    );
  }
}
