import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_list/data/repository/repository.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:movie_list/ui/theme_data.dart';
import 'package:provider/provider.dart';

import '../common_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Repository<MovieEntity> repository =
        Provider.of<Repository<MovieEntity>>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightThemeColors.secondary,
        title: Row(
          children: const [
            Icon(CupertinoIcons.film),
            SizedBox(width: 16),
            Text('Favorite Movies'),
          ],
        ),
        actions: [
          Row(
            children: const [
              Icon(CupertinoIcons.ellipsis),
              SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: repository.tmdb.getAllMovies(),
        builder: (BuildContext context, AsyncSnapshot<List<MovieEntity>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return MovieListItem(movieEntity: snapshot.data![index]);
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
