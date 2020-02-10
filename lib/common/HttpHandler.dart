import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/Cast.dart';
import 'dart:convert';
import 'Constants.dart';
import 'package:movie_app/models/Media.dart';
import 'package:movie_app/common/MediaProvides.dart';

class HttpHandler{
  static final _httphandler = new HttpHandler();
  final String _baseUrl = "api.themoviedb.org";
  final String _language = "es-ES";

  static HttpHandler get() {
    return _httphandler;
  }
    Future<dynamic>getJson(Uri uri )async{
      http.Response response = await http.get(uri);
      return json.decode(response.body);

    }
    Future<List<Media>>fetchMovies({String category : "populares"}) async {
      var uri = new  Uri.http(_baseUrl, "3/movie/$category",{
        'api_key': API_KEY,
        'page' : '1',
        'language': _language
      });

      return getJson(uri).then(((data)=>       
      data['results'].map<Media>((item)=> new  Media(item, MediaType.movie)).toList() 
      ));
    }

     Future<List<Media>>fetchShow({String category : "Populares"}) async {
      var uri = new  Uri.http(_baseUrl, "3/tv/$category",{
        'api_key': API_KEY,
        'page' : '1',
        'language': _language
      });

      return getJson(uri).then(((data)=>       
      data['results'].map<Media>((item)=> new  Media(item, MediaType.show)).toList() 
      ));
    }

    Future<List<Cast>>fetchCreditMovies(int mediaID)  async {
      var uri = new  Uri.http(_baseUrl, "3/movie/$mediaID/credits",{
        'api_key': API_KEY,
        'page' : '1',
        'language': _language
      });

      return getJson(uri).then(((data)=>       
      data['cast'].map<Cast>((item)=> new  Cast(item, MediaType.movie)).toList() 
      ));
    }

    
    Future<List<Cast>>fetchCreditShows(int mediaID)  async {
      var uri = new  Uri.http(_baseUrl, "3/tv/$mediaID/credits",{
        'api_key': API_KEY,
        'page' : '1',
        'language': _language
      });

      return getJson(uri).then(((data)=>       
      data['cast'].map<Cast>((item)=> new  Cast(item, MediaType.show)).toList() 
      ));
    }
    
    
}