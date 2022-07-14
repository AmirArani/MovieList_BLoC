import 'package:dio/dio.dart';
import 'package:movie_list/models/common.dart';
import 'package:movie_list/models/tv_show_entity.dart';

import '../../../common/constants.dart';

abstract class ITvShowDetailDataSource {
  Future<BackdropEntity> getTvShowBackdrop({required int id});
  Future<TvShowDetailEntity> getTvShowDetail({required int id});
}

class TvShowDetailDataSource implements ITvShowDetailDataSource {
  final Dio httpClient;

  TvShowDetailDataSource(this.httpClient);

  @override
  Future<BackdropEntity> getTvShowBackdrop({required int id}) async {
    String getTvShowBackdropPATH = 'tv/$id?api_key=${Constants.apiKey}';
    final response = await httpClient.get(getTvShowBackdropPATH);
    final BackdropEntity backdrop;

    backdrop = BackdropEntity.fromJson(response.data);

    return backdrop;
  }

  @override
  Future<TvShowDetailEntity> getTvShowDetail({required int id}) async {
    String getTvShowDetailPath = 'tv/$id?api_key=${Constants.apiKey}';
    final response = await httpClient.get(getTvShowDetailPath);
    final TvShowDetailEntity tvShowDetailEntity;

    tvShowDetailEntity = TvShowDetailEntity.fromJson(response.data);

    return tvShowDetailEntity;
  }
}
