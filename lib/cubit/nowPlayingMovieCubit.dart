import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:movica/cubit/trendingMovieState.dart';
import 'package:movica/cubit/nowPlayingMovieState.dart';
import 'package:movica/models/trendingMoviesModel.dart';

import '../models/movieModel.dart';

class nowPlayingMovieCubit extends Cubit<nowPlayingMovieState> {
  nowPlayingMovieCubit()
      : super(
            nowPlayingMovieState(code: "10", message: "", nowPlayingMovie: []));
  getList() async {
    final dio = Dio();

    try {
      Response<Map> response = await dio.request(
        "https://api.themoviedb.org/3/movie/now_playing?api_key=a2f16e775a1170487f03e87709bb6ef8&language=en-US&page=1",
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

      emit(nowPlayingMovieState(
          code: "00", message: "", nowPlayingMovie: nowPlayingMovie));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(nowPlayingMovieState(
            code: (e.response!.data["status_code"].toString()),
            message: e.response!.data["status_message"],
            nowPlayingMovie: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(nowPlayingMovieState(
            code: "10", message: 'catched', nowPlayingMovie: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(nowPlayingMovieState(
            code: "10", message: 'check your connection', nowPlayingMovie: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(nowPlayingMovieState(
            code: "10",
            message: 'unable to connect to the server',
            nowPlayingMovie: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(nowPlayingMovieState(
            code: "10", message: 'Something went wrong', nowPlayingMovie: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
