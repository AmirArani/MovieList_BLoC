import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/data/repository/person_repository.dart';
import 'package:movie_list/gen/assets.gen.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:movie_list/models/person_entity.dart';
import 'package:movie_list/models/tv_show_entity.dart';

import '../common_widgets.dart';
import '../theme_data.dart';

class ArtistScreen extends StatelessWidget {
  final PersonEntity personEntity;

  const ArtistScreen({Key? key, required this.personEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: LightThemeColors.background,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 64),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
            child: AppBar(
              elevation: 0,
              backgroundColor: LightThemeColors.primary.withOpacity(0.8),
              centerTitle: true,
              title: Text(personEntity.name),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 124),
            ProfilePicturesCarousel(personEntity: personEntity),
            const SizedBox(height: 64),
            Overview(personEntity: personEntity),
          ],
        ),
      ),
    );
  }
}

class ProfilePicturesCarousel extends StatelessWidget {
  const ProfilePicturesCarousel({
    Key? key,
    required this.personEntity,
  }) : super(key: key);

  final PersonEntity personEntity;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: personRepository.getImages(id: personEntity.id),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Carousel(items: snapshot.data);
        } else {
          return Hero(
            transitionOnUserGestures: true,
            tag: personEntity.id.toString() + 'artist',
            child: Center(
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w185' + personEntity.profilePath,
                fadeInCurve: Curves.easeIn,
                imageBuilder: (context, imageProvider) => Container(
                  height: 300,
                  width: 200.1,
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: imageProvider, fit: BoxFit.cover),
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class Carousel extends StatelessWidget {
  final List<String>? items;

  const Carousel({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: items?.length,
      itemBuilder: (context, index, realIndex) {
        return CarouselItem(item: items![index]);
      },
      options: CarouselOptions(
        autoPlay: true,
        height: 300,
        aspectRatio: 0.667,
        enlargeCenterPage: true,
        enlargeStrategy: CenterPageEnlargeStrategy.scale,
        enableInfiniteScroll: false,
        initialPage: 0,
        viewportFraction: 0.5,
        pageSnapping: true,
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final String item;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://image.tmdb.org/t/p/w300' + item,
      fadeInCurve: Curves.easeIn,
      errorWidget: (context, url, error) => const Icon(Icons.error),
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
      //TODO: USE SHIMMER IN PLACEHOLDER!!!!
      // placeholder: (context, url) =>
      //     const CircularProgressIndicator(),
    );
  }
}

class Overview extends StatefulWidget {
  const Overview({
    Key? key,
    required this.personEntity,
  }) : super(key: key);

  final PersonEntity personEntity;

  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  bool isReadMore = false;
  final int maxLines = 6;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Overview',
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 8),
              FutureBuilder(
                future: personRepository.getPersonDetail(id: widget.personEntity.id),
                builder: (BuildContext context,
                    AsyncSnapshot<PersonDetailEntity> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              snapshot.data!.knownForDepartment,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 12),
                            const Text('|'),
                            const SizedBox(width: 12),
                            Assets.img.icons.birthdate.svg(height: 20),
                            const SizedBox(width: 8),
                            Text(
                              snapshot.data!.birthday,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 24),
                            Assets.img.icons.deathdate.svg(height: 20),
                            const SizedBox(width: 8),
                            Text(
                              snapshot.data!.deathday,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          snapshot.data!.biography,
                          maxLines: isReadMore ? null : maxLines,
                          overflow: TextOverflow.fade,
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                isReadMore = !isReadMore;
                              });
                            },
                            child: Text(
                              isReadMore ? 'Show Less' : 'Read more...',
                              style: Theme.of(context).textTheme.button,
                            ))
                      ],
                    );
                  } else {
                    //TODO: add shimmer
                    return const CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Assets.img.icons.bestDrama.svg(
                    height: 24,
                    width: 24,
                    color: LightThemeColors.primary,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Movies",
                    style: TextStyle(
                      color: LightThemeColors.primary,
                      fontSize: 21,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        FutureBuilder(
          future: personRepository.getCreditMovies(id: widget.personEntity.id),
          builder:
              (BuildContext context, AsyncSnapshot<List<MovieEntity>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              var themeData = Theme.of(context);
              return HorizontalMovieList(
                movieList: snapshot.data,
                themeData: themeData,
                category: 'x',
              );
            } else {
              return const HorizontalListShimmer();
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 32, right: 32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Assets.img.icons.tvShow.svg(
                height: 24,
                width: 24,
                color: LightThemeColors.primary,
              ),
              const SizedBox(width: 10),
              const Text(
                "Tv Shows",
                style: TextStyle(
                  color: LightThemeColors.primary,
                  fontSize: 21,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        FutureBuilder(
          future: personRepository.getCreditTvShows(id: widget.personEntity.id),
          builder:
              (BuildContext context, AsyncSnapshot<List<TvShowEntity>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              var themeData = Theme.of(context);
              return HorizontalTvShowList(
                tvShows: snapshot.data!,
                themeData: themeData,
                category: 'topA',
              );
            } else {
              return const HorizontalListShimmer();
            }
          },
        ),
      ],
    );
  }
}
