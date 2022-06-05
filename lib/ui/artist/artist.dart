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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 124),
            ProfilePicturesCarousel(personEntity: personEntity),
            const SizedBox(height: 64),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Column(
                children: [
                  Text(
                    'Overview',
                  ),
                  SizedBox(height: 12),
                  Text(personEntity.name),
                ],
              ),
            ),
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
        enableInfiniteScroll: true,
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
      imageUrl: 'https://image.tmdb.org/t/p/w185' + item,
      fadeInCurve: Curves.easeIn,
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
