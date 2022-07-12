import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../models/genreModel.dart';
import 'genreState.dart';

class genreCubit extends Cubit<genreState> {
  genreCubit() : super(genreState(code: "10", message: "", genre: []));
  getList() async {
    final dio = Dio();

    try {
      Response<Map> response = await dio.request(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=a2f16e775a1170487f03e87709bb6ef8&language=en-US",
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

      List<GenreModel> genres = [];
      responseBody!["genres"].forEach((element) {
        GenreModel genre = GenreModel.fromJson(element);
        genres.add(genre);
      });

      emit(genreState(code: "00", message: "", genre: genres));
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        emit(genreState(
            code: (e.response!.data["status_code"].toString()),
            message: e.response!.data["status_message"],
            genre: []));
      } else if (e.type == DioErrorType.response) {
        print('catched');
        emit(genreState(code: "10", message: 'catched', genre: []));
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        emit(genreState(
            code: "10", message: 'check your connection', genre: []));
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        emit(genreState(
            code: "10", message: 'unable to connect to the server', genre: []));
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        emit(
            genreState(code: "10", message: 'Something went wrong', genre: []));
        return;
      }
      print(e);
    } catch (e) {
      print("error");
      print(e);
    }
  }
}
