import 'package:movie_list/data/source/data_source.dart';


class Repository<T> implements DataSource {
  final DataSource<T> tmdb;
  // final DataSource<T> local;

  // inject dependency to the data source as constructor parameter
  Repository(this.tmdb);



}
