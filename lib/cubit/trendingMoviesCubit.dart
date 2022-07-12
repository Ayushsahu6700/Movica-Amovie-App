import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:movica/cubit/trendingMovieState.dart';
import 'package:movica/models/trendingMoviesModel.dart';

import '../models/movieModel.dart';

class trendingMovieCubit extends Cubit<trendingMovieState> {
  trendingMovieCubit()
      : super(trendingMovieState(code: "10", message: "", trendingMovie: []));
  getList() async {
    final dio = Dio();

    try {
      Response<Map> response = await dio.request(
        "https://api.themoviedb.org/3/trending/movie/day?api_key=a2f16e775a1170487f03e87709bb6ef8",
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

      List<MovieModel> trendingMovies = [];
      responseBody!["results"].forEach((element) {
        MovieModel movie = MovieModel.fromJson(element);
        trendingMovies.add(movie);
      });

      emit(trendingMovieState(
          code: "00", message: "", trendingMovie: trendingMovies));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(trendingMovieState(
            code: (e.response!.data["status_code"].toString()),
            message: e.response!.data["status_message"],
            trendingMovie: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(trendingMovieState(
            code: "10", message: 'catched', trendingMovie: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(trendingMovieState(
            code: "10", message: 'check your connection', trendingMovie: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(trendingMovieState(
            code: "10",
            message: 'unable to connect to the server',
            trendingMovie: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(trendingMovieState(
            code: "10", message: 'Something went wrong', trendingMovie: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
