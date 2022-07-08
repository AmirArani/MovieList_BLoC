import 'package:dio/dio.dart';
import 'package:movie_list/models/common.dart';

import '../../../common/constants.dart';

abstract class ITvShowDetailDataSource {
  Future<BackdropEntity> getTvShowBackdrop({required int id});
}

class TvShowDetailDataSource implements ITvShowDetailDataSource {
  final Dio httpClient;

  TvShowDetailDataSource(this.httpClient);

  @override
  Future<BackdropEntity> getTvShowBackdrop({required int id}) async {
    String getTvShowBackdrop = 'tv/$id?api_key=${Constants.apiKey}';
    final response = await httpClient.get(getTvShowBackdrop);
    final BackdropEntity backdrop;

    backdrop = BackdropEntity.fromJson(response.data);

    return backdrop;
  }
}
