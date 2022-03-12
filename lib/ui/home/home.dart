import 'package:flutter/material.dart';
import 'package:movie_list/data/repository/repository.dart';
import 'package:movie_list/models/movie_entity.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Repository<MovieEntity> repository =
        Provider.of<Repository<MovieEntity>>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Movie List')),
      body: FutureBuilder(
        future: repository.tmdb.getAllMovies(),
        builder: (BuildContext context, AsyncSnapshot<List<MovieEntity>> snapshot) {
          // String test = repository.tmdb.getAllMovies().toString();
          // print(test);
          // Text(repository.tmdb.getAllMovies().toString());
          // return const Text("data");
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Text(snapshot.data![index].title);
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
