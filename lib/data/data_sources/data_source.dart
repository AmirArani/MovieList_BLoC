abstract class DataSource<T> {
  Future <List<T>> getAllMovies();

  Future <List<T>> searchMovies({required String searchKeyword});
}