import 'package:dio/dio.dart';
import 'package:rick_and_morty/constants/strings.dart';

class CharactersWebService{
  late Dio dio;

  CharactersWebService(){
    BaseOptions options =BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20*1000,
      receiveTimeout: 20*1000,
    );
    dio=Dio(options);
  }

  Future<List<dynamic>> getAllCharacters(int page) async{
    try{
      Response response=await dio.get('character?page=${page}');
      return response.data['results'];
    }catch(e){
      return [];
    }
  }
  Future<List<dynamic>> searchCharacter(String name) async{
    try{
      Response response=await dio.get('character/?name=${name}');
      int pages =response.data['info']['pages'];
      if(pages>1){
        int currentPage =1;
        List results=[];
        while(currentPage<=pages){
          Response searchResponse=await dio.get('character/?page=${currentPage}&name=${name}');
          results.addAll(searchResponse.data['results']);
          currentPage++;
        }
        return results;
      }else {
        return response.data['results'];
      }
    }catch(e){
      return [];
    }
  }
}