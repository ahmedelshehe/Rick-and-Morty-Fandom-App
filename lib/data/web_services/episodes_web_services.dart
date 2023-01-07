import 'package:dio/dio.dart';
import 'package:rick_and_morty/constants/strings.dart';

class EpisodesWebService{
  late Dio dio;
  EpisodesWebService(){
    BaseOptions options =BaseOptions(
      baseUrl: episodesUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20*1000,
      receiveTimeout: 20*1000,
    );
    dio=Dio(options);
  }

  Future<List> getAllEpisodes() async{
    List allEpisodes =[];
    List<String> seasons =['1','2','3','4','5','6'];
    try{
      for(String season in seasons){
        Response response=await dio.get(season,queryParameters:{'api_key': apiKey} );
        allEpisodes.addAll(response.data['episodes']);
      }
    }catch(e){
      rethrow;
    }
    return allEpisodes;
  }
}