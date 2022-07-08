import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/data/repository/tv_show_detail_repository.dart';
import 'package:movie_list/models/tv_show_entity.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/common.dart';
import '../theme_data.dart';

class TvShowScreen extends StatelessWidget {
  const TvShowScreen({
    Key? key,
    required this.tvShow,
    required this.category,
  }) : super(key: key);

  final TvShowEntity tvShow;
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
                  _TopBackDrop(tvShowID: tvShow.id),
                  // _MainPoster(
                  //   category: category,
                  //   posterPath: tvShow.posterPath,
                  //   id: tvShow.id,
                  // ),
                  // _TitleAndInfo(title: tvShow.name, id: tvShow.id),
                ],
              ),
            ),
            // _BottomTabBar(movie: tvShow)
          ],
        ),
      ),
    );
  }
}

class _TopBackDrop extends StatelessWidget {
  const _TopBackDrop({
    Key? key,
    required this.tvShowID,
  }) : super(key: key);

  final int tvShowID;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      child: FutureBuilder(
        future: tvShowDetailRepository.getTvShowBackdrop(id: tvShowID),
        builder: (BuildContext context, AsyncSnapshot<BackdropEntity> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return CachedNetworkImage(
              imageUrl:
                  'https://image.tmdb.org/t/p/w400${snapshot.data!.backdropPath}',
              fadeInCurve: Curves.easeIn,
              errorWidget: (context, url, error) => Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.57,
                  child: const Center(child: Icon(Icons.error))),
            );
          } else {
            return Shimmer(
              gradient: LinearGradient(
                colors: [
                  LightThemeColors.tertiary.withOpacity(0.3),
                  LightThemeColors.secondary.withOpacity(0.2),
                  LightThemeColors.secondary.withOpacity(0.2),
                  LightThemeColors.tertiary.withOpacity(0.3),
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
