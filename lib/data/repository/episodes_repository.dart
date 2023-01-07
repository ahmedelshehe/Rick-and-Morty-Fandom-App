import 'package:rick_and_morty/data/models/episode.dart';
import 'package:rick_and_morty/data/web_services/episodes_web_services.dart';

class EpisodesRepository{
  final EpisodesWebService episodesWebService;

  EpisodesRepository(this.episodesWebService);

  Future<List<Episode>> getAllEpisodes() async{
   final episodes= await episodesWebService.getAllEpisodes().catchError((e){throw(e);});
   return episodes.map((e) => Episode.fromJson(e)).toList();
  }
}