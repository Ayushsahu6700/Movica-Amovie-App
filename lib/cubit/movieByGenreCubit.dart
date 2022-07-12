import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:movica/cubit/trendingMovieState.dart';
import 'package:movica/cubit/nowPlayingMovieState.dart';
import 'package:movica/models/trendingMoviesModel.dart';

import '../models/movieModel.dart';
import 'movieByGenreState.dart';

class movieByGenreCubit extends Cubit<movieByGenreState> {
  movieByGenreCubit()
      : super(movieByGenreState(code: "10", message: "", movieByGenre: []));
  getList(int gen) async {
    final dio = Dio();

    try {
      Response<Map> response = await dio.request(
        "https://api.themoviedb.org/3/discover/movie?api_key=a2f16e775a1170487f03e87709bb6ef8&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_genres=$gen&with_watch_monetization_types=free",
        options: Options(
          method: 'GET',
          headers: {'content-Type': 'application/json'},
        ),
      );

      // print(response.data);
      print("Status code---------------------${response.statusCode}");
      String responseString = response.data.toString();
      print(responseString);
      Map? responseBody = response.data;

      List<MovieModel> nowPlayingMovie = [];
      responseBody!["results"].forEach((element) {
        MovieModel movie = MovieModel.fromJson(element);
        nowPlayingMovie.add(movie);
      });

      emit(movieByGenreState(
          code: "00", message: "", movieByGenre: nowPlayingMovie));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(movieByGenreState(
            code: (e.response!.data["status_code"].toString()),
            message: e.response!.data["status_message"],
            movieByGenre: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(movieByGenreState(
            code: "10", message: 'catched', movieByGenre: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(movieByGenreState(
            code: "10", message: 'check your connection', movieByGenre: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(movieByGenreState(
            code: "10",
            message: 'unable to connect to the server',
            movieByGenre: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(movieByGenreState(
            code: "10", message: 'Something went wrong', movieByGenre: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
