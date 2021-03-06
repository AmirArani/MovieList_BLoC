import '../../common/http_client.dart';
import '../../models/common.dart';
import '../source/remote/tv_show_detail_data_source.dart';

final tvShowDetailRepository =
    TvShowDetailRepository(TvShowDetailDataSource(httpClient));

abstract class ITvShowDetailRepository {
  Future<BackdropEntity> getTvShowBackdrop({required int id});
}

class TvShowDetailRepository implements ITvShowDetailRepository {
  final ITvShowDetailDataSource dataSource;

  TvShowDetailRepository(this.dataSource);

  @override
  Future<BackdropEntity> getTvShowBackdrop({required int id}) {
    return dataSource.getTvShowBackdrop(id: id);
  }
}
