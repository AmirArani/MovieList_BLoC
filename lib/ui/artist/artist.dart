import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/data/repository/person_repository.dart';
import 'package:movie_list/models/person_entity.dart';

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
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 124),
              FutureBuilder(
                future: personRepository.getImages(id: personEntity.id),
                builder:
                    (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return CarouselSlider.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index, realIndex) {
                        return CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w185' +
                              snapshot.data![index],
                          fadeInCurve: Curves.easeIn,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20))),
                          ),
                          //TODO: USE SHIMMER IN PLACEHOLDER!!!!
                          // placeholder: (context, url) =>
                          //     const CircularProgressIndicator(),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        height: 300,
                        aspectRatio: 0.667,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                        enableInfiniteScroll: true,
                        initialPage: 0,
                        viewportFraction: 0.5,
                        pageSnapping: true,
                      ),
                    );
                  } else {
                    return Hero(
                        transitionOnUserGestures: true,
                        tag: personEntity.id.toString() + 'artist',
                        child: CachedNetworkImage(
                          imageUrl: 'https://image.tmdb.org/t/p/w185' +
                              personEntity.profilePath,
                          fadeInCurve: Curves.easeIn,
                          imageBuilder: (context, imageProvider) => Container(
                            height: 300,
                            width: 200.1,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20))),
                          ),
                        ));
                  }
                },
              )
              // Hero(
              //   transitionOnUserGestures: true,
              //   tag: personEntity.id.toString() + 'artist',
              //   child: ClipRRect(
              //     borderRadius: const BorderRadius.all(Radius.circular(20)),
              //     child: CachedNetworkImage(
              //       imageUrl:
              //           'https://image.tmdb.org/t/p/w185' + personEntity.profilePath,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
