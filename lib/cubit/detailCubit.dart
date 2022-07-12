import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:movica/cubit/trendingMovieState.dart';
import 'package:movica/models/detailModel.dart';
import 'package:movica/models/trendingMoviesModel.dart';

import '../models/genreModel.dart';
import '../models/movieModel.dart';
import 'detailState.dart';

class detailCubit extends Cubit<detailState> {
  detailCubit()
      : super(detailState(
            code: "10",
            message: "",
            detail: DetailModel.fromJson({}),
            genre: []));
  getList(int id) async {
    final dio = Dio();

    try {
      Response<Map> response = await dio.request(
        "https://api.themoviedb.org/3/movie/${id.toString()}?api_key=a2f16e775a1170487f03e87709bb6ef8&language=en-US",
        options: Options(
          method: 'GET',
          headers: {'content-Type': 'application/json'},
        ),
      );

      // print(response.data);
      print("Status code---------------------${response.statusCode}");
      // String responseString = response.data.toString();
      // print(responseString);
      Map? responseBody = response.data;
      Map<String, dynamic> res =
          responseBody!.map((key, value) => MapEntry(key.toString(), value));
      DetailModel det = DetailModel.fromJson(res);
      // responseBody!["results"].forEach((element) {
      //   MovieModel movie = MovieModel.fromJson(element);
      //   trendingMovies.add(movie);
      // });
      List<GenreModel> genres = [];
      responseBody["genres"].forEach((element) {
        GenreModel genre = GenreModel.fromJson(element);
        genres.add(genre);
      });
      emit(detailState(code: "00", message: "", detail: det, genre: genres));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(detailState(
            code: (e.response!.data["status_code"].toString()),
            message: e.response!.data["status_message"],
            detail: DetailModel.fromJson({}),
            genre: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(detailState(
            code: "10",
            message: 'catched',
            detail: DetailModel.fromJson({}),
            genre: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(detailState(
            code: "10",
            message: 'check your connection',
            detail: DetailModel.fromJson({}),
            genre: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(detailState(
            code: "10",
            message: 'unable to connect to the server',
            detail: DetailModel.fromJson({}),
            genre: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(detailState(
            code: "10",
            message: 'Something went wrong',
            detail: DetailModel.fromJson({}),
            genre: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
