import 'package:flutter/material.dart';
import 'package:movie_list/models/tv_show_entity.dart';

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
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [],
      ),
    );
  }
}
