import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:movica/models/trendingMoviesModel.dart';

import '../models/movieModel.dart';
import '../models/screenModel.dart';
import 'detailState.dart';
import 'getImageState.dart';

class getImageCubit extends Cubit<getImageState> {
  getImageCubit()
      : super(getImageState(
            code: "10", message: "", image: ScreenModel.fromJson({})));
  getList(int id) async {
    final dio = Dio();

    try {
      Response<Map> response = await dio.request(
        "https://api.themoviedb.org/3/movie/${id.toString()}/images?api_key=a2f16e775a1170487f03e87709bb6ef8&language=en-US",
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
      ScreenModel det = ScreenModel.fromJson(res);
      // responseBody!["results"].forEach((element) {
      //   MovieModel movie = MovieModel.fromJson(element);
      //   trendingMovies.add(movie);
      // });

      emit(getImageState(code: "00", message: "", image: det));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(getImageState(
            code: (e.response!.data["status_code"].toString()),
            message: e.response!.data["status_message"],
            image: ScreenModel.fromJson({})));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(getImageState(
            code: "10", message: 'catched', image: ScreenModel.fromJson({})));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(getImageState(
            code: "10",
            message: 'check your connection',
            image: ScreenModel.fromJson({})));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(getImageState(
            code: "10",
            message: 'unable to connect to the server',
            image: ScreenModel.fromJson({})));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(getImageState(
            code: "10",
            message: 'Something went wrong',
            image: ScreenModel.fromJson({})));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
